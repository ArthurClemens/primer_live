Application.put_env(:sample, PrimerLiveWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4001],
  server: true,
  live_view: [signing_salt: "aaaaaaaa"],
  secret_key_base: String.duplicate("a", 64)
)

Mix.install([
  {:floki, "~> 0.36"},
  {:jason, "~> 1.4"},
  {:phoenix_live_view, "~> 0.20"},
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

  def mount(params, _session, socket) do
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

    path = (params["path"] || []) |> List.first()
    path = if is_nil(path), do: assertions |> List.first() |> List.first(), else: path
    not_found = not Map.has_key?(assertion_groups, path)

    current_assertions =
      if not not_found do
        Map.get(assertion_groups, path)
      else
        []
      end

    socket =
      socket
      |> assign(:assertions, assertions)
      |> assign(:current_assertions, current_assertions)
      |> assign(:path, path)
      |> assign(:not_found, not_found)

    {:ok, socket}
  end

  defp phx_vsn, do: Application.spec(:phoenix, :vsn)
  defp lv_vsn, do: Application.spec(:phoenix_live_view, :vsn)

  def render("live.html", assigns) do
    ~H"""
    <script src={"https://cdn.jsdelivr.net/npm/phoenix@#{phx_vsn()}/priv/static/phoenix.min.js"}>
    </script>
    <script
      src={"https://cdn.jsdelivr.net/npm/phoenix_live_view@#{lv_vsn()}/priv/static/phoenix_live_view.min.js"}
    >
    </script>
    <script>
      let liveSocket = new window.LiveView.LiveSocket("/live", window.Phoenix.Socket)
      liveSocket.connect()
    </script>
    <link phx-track-static rel="stylesheet" href="/primer_live/primer-live.min.css" />
    <script defer phx-track-static type="text/javascript" src="/primer_live/primer-live.min.js">
    </script>
    <style>
      .assertion-page {
        display: flex;
        flex-direction: column;
        gap: 1.5rem;
        padding: 1rem 0 3rem 0;
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

      .assertion-html {
        display: flex;
        flex-direction: column;
        gap: 1rem;
      }
    </style>
    <%= @inner_content %>
    """
  end

  def render(assigns) do
    ~H"""
    <Primer.header>
      <:item class="d-none d-md-flex">PrimerLive Assertions Viewer</:item>
    </Primer.header>
    <Primer.layout>
      <:sidebar>
        <Primer.action_list>
          <%= for [component, _] <- @assertions do %>
            <Primer.action_list_item is_selected={@path == component}>
              <:link navigate={"/#{component}"}>
                <%= component %>
              </:link>
            </Primer.action_list_item>
          <% end %>
        </Primer.action_list>
      </:sidebar>
      <:main>
        <div class="assertion-page container-md">
          <%= if @not_found do %>
            <h1>Component not found</h1>
          <% else %>
            <h1><%= @path %></h1>
            <div class="assertions">
              <%= for assertion <- @current_assertions do %>
                <.assertion {assertion} />
              <% end %>
            </div>
          <% end %>
        </div>
      </:main>
    </Primer.layout>
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
      <h2><%= @assertion_name %></h2>
      <div class="assertion-html">
        <%= Phoenix.HTML.raw(@html) %>
      </div>
    </section>
    """
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

  plug(PrimerLiveWeb.Router)
end

{:ok, _} = Supervisor.start_link([PrimerLiveWeb.Endpoint], strategy: :one_for_one)
Process.sleep(:infinity)
