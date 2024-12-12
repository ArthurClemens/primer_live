#!/usr/bin/env elixir

Application.put_env(:sample, PrimerLiveWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4001],
  server: true,
  live_view: [signing_salt: "aaaaaaaa"],
  secret_key_base: String.duplicate("a", 64)
)

Mix.install([
  {:floki, "~> 0.36"},
  {:jason, "~> 1.4"},
  {:phoenix_live_view, "~> 1.0"},
  {:phoenix, "~> 1.7"},
  {:plug_cowboy, "~> 2.7"},
  {:primer_live, path: "."}
])

defmodule PrimerLiveWeb.ErrorView do
  def render(template, _), do: Phoenix.Controller.status_message_from_template(template)
end

defmodule PrimerLiveWeb.ComponentLive do
  use Phoenix.LiveView, layout: {__MODULE__, :live}
  alias PrimerLive.Component, as: Primer
  alias Phoenix.LiveView.JS

  def mount(_params, _session, socket) do
    assertion_groups =
      Path.wildcard("./test/assertions/*/*.html")
      |> Enum.map(fn path ->
        parts = String.split(path, "/")
        [_, _, component_dir, assertion_file] = parts

        %{
          path: path,
          component: String.trim_trailing(component_dir, "_test"),
          assertion_name:
            String.trim_trailing(assertion_file, ".html") |> String.replace("-", " ")
        }
      end)
      |> Enum.group_by(& &1.component)

    assertions =
      assertion_groups
      |> Enum.map(fn {name, data} ->
        [name, data]
      end)
      |> Enum.sort()

    socket =
      socket
      |> assign(:assertions, assertions)
      |> assign(:assertion_groups, assertion_groups)
      |> assign(:current_assertions, [])
      |> assign(:path, nil)
      |> assign(:not_found, false)

    {:ok, socket}
  end

  defp phx_vsn, do: Application.spec(:phoenix, :vsn)
  defp lv_vsn, do: Application.spec(:phoenix_live_view, :vsn)
  defp pl_vsn, do: "0.8.0"
  # Application.spec(:primer_live, :vsn)

  def render("live.html", assigns) do
    ~H"""
    <script src={"https://cdn.jsdelivr.net/npm/phoenix@#{phx_vsn()}/priv/static/phoenix.min.js"}>
    </script>
    <script
      src={"https://cdn.jsdelivr.net/npm/phoenix_live_view@#{lv_vsn()}/priv/static/phoenix_live_view.min.js"}
    >
    </script>
    <script src={"https://cdn.jsdelivr.net/npm/primer-live@#{pl_vsn()}/priv/static/primer-live.js"}>
    </script>
    <script>
      let hooks = {};
      hooks.Prompt = window.Prompt;
      let liveSocket = new window.LiveView.LiveSocket("/live", window.Phoenix.Socket, {
        hooks
      })
      liveSocket.connect()
    </script>
    <link phx-track-static rel="stylesheet" href="/primer_live/primer-live.min.css" />
    <script defer phx-track-static type="text/javascript" src="/primer_live/primer-live.min.js">
    </script>
    <style>
      :root {
        --topbar-height: 53px;
      }
      .page[data-component=textarea] .FormControl-inlineValidation.phx-no-feedback,
      .page[data-component=textinput] .FormControl-inlineValidation.phx-no-feedback,
      .page[data-component=input_validation_message] .FormControl-inlineValidation.phx-no-feedback {
        display: flex !important;
      }

      .assertion-page {
        display: flex;
        flex-direction: column;
        gap: 1.5rem;
        padding: 1rem 0 3rem 0;
      }

      .topbar {
        position: sticky;
        top: 0;
        z-index: 100;
        height: var(--topbar-height);
      }

      .side-menu {
        position: sticky;
        top: var(--topbar-height);
        overflow-y: auto;
        max-height: calc(100vh - var(--topbar-height));
        max-height: calc(100dvh - var(--topbar-height));
      }

      .assertions {
        display: flex;
        flex-direction: column;
        gap: 2rem;
      }

      .assertion-section {
        display: flex;
        flex-direction: column;
        gap: 1rem;
      }

      .assertion-html > * + * {
        margin-top: 1rem !important;
      }
    </style>
    {@inner_content}
    """
  end

  def render(assigns) do
    ~H"""
    <div class="page" data-component={@path}>
      <Primer.header class="topbar">
        <:item class="d-none d-md-flex">PrimerLive Assertions Viewer</:item>
        <:item is_full_width />
        <:item>
          <Primer.button phx-click={JS.toggle_attribute({"dir", "rtl", ""}, to: "html")}>
            Toggle RTL
          </Primer.button>
        </:item>
      </Primer.header>
      <Primer.layout is_divided>
        <:sidebar>
          <Primer.action_list class="side-menu">
            <%= for [component, _] <- @assertions do %>
              <Primer.action_list_item is_selected={@path == component}>
                <:link navigate={"/#{component}"}>
                  {component}
                </:link>
              </Primer.action_list_item>
            <% end %>
          </Primer.action_list>
        </:sidebar>
        <:divider></:divider>
        <:main>
          <div class="assertion-page container-md">
            <%= if @not_found do %>
              <h1>Component not found</h1>
            <% else %>
              <h1>{@path}</h1>
              <div class="assertions">
                <%= for assertion <- @current_assertions do %>
                  <.assertion {assertion} />
                <% end %>
              </div>
            <% end %>
          </div>
        </:main>
      </Primer.layout>
    </div>
    """
  end

  attr :assertion_name, :string, required: true
  attr :path, :string, required: true

  defp assertion(assigns) do
    assertion_html = File.read!(assigns.path)
    doc = Floki.parse_document!(assertion_html)
    html = Floki.raw_html(doc)

    assigns = assigns |> assign(:html, html)

    ~H"""
    <section class="assertion-section">
      <h2>{@assertion_name}</h2>
      <div class="assertion-html">
        {Phoenix.HTML.raw(@html)}
      </div>
    </section>
    """
  end

  def handle_params(params, _url, socket) do
    path = (params["path"] || []) |> List.first()

    path =
      if is_nil(path), do: socket.assigns.assertions |> List.first() |> List.first(), else: path

    not_found = not Map.has_key?(socket.assigns.assertion_groups, path)

    current_assertions =
      if not not_found do
        Map.get(socket.assigns.assertion_groups, path)
      else
        []
      end

    socket =
      socket
      |> assign(:path, path)
      |> assign(:not_found, not_found)
      |> assign(:current_assertions, current_assertions)

    {:noreply, socket}
  end
end

defmodule PrimerLiveWeb.Router do
  use Phoenix.Router
  import Phoenix.LiveView.Router

  pipeline :browser do
    plug(:accepts, ["html"])
  end

  scope "/", PrimerLiveWeb do
    pipe_through(:browser)

    live("/", ComponentLive, :index)
    live("/*path", ComponentLive, :index)
  end
end

defmodule PrimerLiveWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :sample
  socket("/live", Phoenix.LiveView.Socket)

  # PrimerLive resources
  plug(Plug.Static,
    at: "/primer_live",
    from: {:primer_live, "priv/static"}
  )

  plug(Plug.Static,
    at: "/images",
    from: "scripts/elixir/assertions_viewer/images"
  )

  plug(PrimerLiveWeb.Router)
end

{:ok, _} = Supervisor.start_link([PrimerLiveWeb.Endpoint], strategy: :one_for_one)
Process.sleep(:infinity)
