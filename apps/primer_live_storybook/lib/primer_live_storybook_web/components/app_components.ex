defmodule PrimerLiveStorybookWeb.AppComponents do
  use Phoenix.Component
  use PrimerLive

  import Phoenix.LiveViewTest

  alias PrimerLive.Helpers.AttributeHelpers

  alias Makeup
  alias Phoenix.HTML
  alias PrimerLiveStorybookWeb.{Config, NavigationTopicHelpers}

  # ------------------------------------------------------------------------------------
  # page_layout
  # ------------------------------------------------------------------------------------

  attr(:path, :string, required: true)
  attr(:theme_state, :map, required: true)
  attr(:default_theme_state, :map, required: true)
  attr(:ui_changeset, :map, required: true)
  slot(:inner_block, required: true)

  def page_layout(assigns) do
    ~H"""
    <.theme color_mode="dark" class="sb-topbar">
      <.header>
        <:item class="flex-shrink-0">
          <.link patch="/" class="sb-header__link">
          <svg aria-hidden="true" role="img" class="StyledOcticon-sc-1lhyyr-0 kDaXaG" viewBox="0 0 16 16" width="32" height="32" fill="currentColor" style="display: inline-block; user-select: none; vertical-align: text-bottom; overflow: visible;"><path fill-rule="evenodd" d="M8 0C3.58 0 0 3.58 0 8c0 3.54 2.29 6.53 5.47 7.59.4.07.55-.17.55-.38 0-.19-.01-.82-.01-1.49-2.01.37-2.53-.49-2.69-.94-.09-.23-.48-.94-.82-1.13-.28-.15-.68-.52-.01-.53.63-.01 1.08.58 1.23.82.72 1.21 1.87.87 2.33.66.07-.52.28-.87.51-1.07-1.78-.2-3.64-.89-3.64-3.95 0-.87.31-1.59.82-2.15-.08-.2-.36-1.02.08-2.12 0 0 .67-.21 2.2.82.64-.18 1.32-.27 2-.27.68 0 1.36.09 2 .27 1.53-1.04 2.2-.82 2.2-.82.44 1.1.16 1.92.08 2.12.51.56.82 1.27.82 2.15 0 3.07-1.87 3.75-3.65 3.95.29.25.54.73.54 1.48 0 1.07-.01 1.93-.01 2.2 0 .21.15.46.55.38A8.013 8.013 0 0016 8c0-4.42-3.58-8-8-8z"></path></svg>
          <span>Primer / Live</span>
          </.link>
        </:item>
        <:item class="d-none d-md-flex">Storybook</:item>
        <:item is_full />
        <:item>
          <.theme_menu theme_state={@theme_state} default_theme_state={@default_theme_state} phx-hook="Theme" id="theme_menu" ui_changeset={@ui_changeset} />
        </:item>
        <:item class="d-lg-none">
          <.button onclick="liveSocket.hooks.Drawer.show()" {PrimerLive.Theme.html_attributes([color_mode: "dark", dark_theme: "dark_high_contrast"])}><.octicon name="three-bars-16" /></.button>
        </:item>
      </.header>
    </.theme>
    <%= render_slot(@inner_block) %>
    """
  end

  attr(:page_title, :string, required: true)
  attr(:path, :string, required: true)
  attr(:theme_state, :map, required: true)
  attr(:default_theme_state, :map, required: true)
  attr(:navigation_topic_state, :map, required: true)
  attr(:ui_changeset, :map, required: true)
  slot(:inner_block, required: true)

  def story_page(assigns) do
    assigns =
      assigns
      |> assign(:page_id, assigns.page_title)

    ~H"""
    <.theme {@theme_state}>
      <.page_layout path={@path} theme_state={@theme_state} default_theme_state={@default_theme_state} ui_changeset={@ui_changeset}>
        <.layout class="sb-page-layout">
          <:sidebar>
            <.sidebar_navigation path={@path} navigation_topic_state={@navigation_topic_state} />
          </:sidebar>
          <:main>
            <article phx-hook="Article" id={@path}>
            <div class="sb-content-row">
              <%= render_slot(@inner_block) %>
            </div>
            </article>
          </:main>
        </.layout>
      </.page_layout>
    </.theme>
    """
  end

  # ------------------------------------------------------------------------------------
  # navigation
  # ------------------------------------------------------------------------------------

  attr(:type, :string, values: ~w(sidebar drawer), required: true)
  attr(:path, :string, required: true)
  attr(:stories, :list, default: [])
  attr(:navigation_topic_state, :map, required: true)
  attr(:onselect, :any)

  def navigation(assigns) do
    topic_id = "navigation_tabs"

    actions =
      NavigationTopicHelpers.navigation_topic_states()
      |> Enum.map(&Map.put(&1, :is_selected, &1.id == assigns.navigation_topic_state))

    is_group_by_topic = assigns.navigation_topic_state === "by_topic"
    # Config.story_groups(assigns.path, is_group_by_topic)
    groups = []

    assigns =
      assigns
      |> assign(:link_attrs,
        is_hover_gray: true
      )
      |> assign(:groups, groups)
      |> assign(:actions, actions)
      |> assign(:topic_id, topic_id)
      |> assign(:onselect, assigns[:onselect])

    ~H"""
      <.action_list class="sb-sidebar__menu">
        <%= for %{title: title, pages: pages, is_group_title: is_group_title, key: key, is_top_separator: is_top_separator, is_bottom_separator: is_bottom_separator} <- @groups do %>
          <%= if is_top_separator do %>
            <.action_list_section_divider />
          <% end %>
          <%= if is_group_title do %>
            <.action_list_section_divider>
              <:title><%= title %></:title>
            </.action_list_section_divider>
          <% end %>
          <%= if key === :tabs do %>
            <.action_list_section_divider>
              <:title><%= title %></:title>
            </.action_list_section_divider>
            <.tabnav aria_label="Component views" class="sb-navigation__tabs">
              <:item :for={action <- @actions} is_small is_selected={action[:is_selected]} phx-click="update_topic_state" phx-value-topic_id={@topic_id} phx-value-data={action.id}>
                <%= action.label %>
              </:item>
            </.tabnav>
          <% else %>
            <%= for %{nav_label: nav_label, is_selected: is_selected, path: path, } <- pages do %>
              <.action_list_item {@link_attrs} is_selected={is_selected}>
                <:link patch={path} onclick={@onselect}>
                  <%= nav_label %>
                </:link>
              </.action_list_item>
              <%= if is_selected && Enum.count(@stories) > 0 do %>
                <.action_list_item leading_visual_width="16">
                  <:sub_group>
                    <.story_page_links stories={@stories} is_sub_group />
                  </:sub_group>
                </.action_list_item>
                <.action_list_section_divider />
              <% end %>
            <% end %>
            <%= if is_bottom_separator do %>
              <.action_list_section_divider />
            <% end %>
          <% end %>
        <% end %>
      </.action_list>
    """
  end

  # ------------------------------------------------------------------------------------
  # sidebar_navigation
  # ------------------------------------------------------------------------------------

  attr(:path, :string, required: true)
  attr(:navigation_topic_state, :map, required: true)

  def sidebar_navigation(assigns) do
    ~H"""
    <.box class="sb-sidebar__outer" phx-hook="SideBar" id="sidebar">
      <.box class="sb-sidebar__inner">
        <.navigation path={@path} navigation_topic_state={@navigation_topic_state} type="sidebar" />
      </.box>
    </.box>
    """
  end

  # ------------------------------------------------------------------------------------
  # drawer_navigation
  # ------------------------------------------------------------------------------------

  attr(:changeset, :map)
  attr(:path, :string, required: true)
  attr(:stories, :list, default: [])
  attr(:navigation_topic_state, :map, required: true)
  attr(:ui_changeset, :map, required: true)

  def drawer_navigation(assigns) do
    ~H"""
    <.form :let={f} for={@ui_changeset} phx-change="update_ui" phx-submit="update_ui">
      <.drawer id="drawer_navigation" is_far_side is_backdrop form={f} field={:mobile_side_drawer_open}>
        <:body width="300px">
          <.navigation path={@path} stories={@stories} navigation_topic_state={@navigation_topic_state} type="drawer" />
        </:body>
      </.drawer>
    </.form>
    """
  end

  # ------------------------------------------------------------------------------------
  # story_page_content
  # ------------------------------------------------------------------------------------

  attr(:page_title, :string, required: true)
  attr(:path, :string, required: true)
  attr(:story_doc_components, :list, default: nil)
  attr(:navigation_topic_state, :map, required: true)
  attr(:stories, :list)
  attr(:changeset, :map, default: nil)
  attr(:ui_changeset, :map, default: nil)
  attr(:page_state, :map, required: true)
  slot(:story_doc)
  slot(:inner_block)

  def story_page_content(assigns) do
    default_story_attrs = %{is_interactive: false}

    stories =
      if !is_nil(assigns[:stories]) do
        assigns[:stories]
        |> Enum.map(&Map.merge(default_story_attrs, &1))
      else
        []
      end

    has_storydoc? = !is_nil(assigns[:story_doc]) && assigns[:story_doc] !== []

    has_storydoc_section? = !is_nil(assigns[:story_doc_components]) || has_storydoc?

    assigns =
      assigns
      |> assign(:stories, stories)
      |> assign(:has_storydoc_section?, has_storydoc_section?)
      |> assign(:has_storydoc?, has_storydoc?)

    ~H"""
    <div class="sb-story-layout">
      <div class="sb-story-layout__main">
        <div class="sb-story-page__content">
          <.styled_html>
            <h1 id="top" class="border-0"><%= @page_title %></h1>
          </.styled_html>
          <%= if @has_storydoc_section? do %>
            <.story_doc components={@story_doc_components}>
              <%= if @has_storydoc? do %>
                <.styled_html><%= render_slot(@story_doc) %></.styled_html>
              <% end %>
            </.story_doc>
          <% end %>
          <%= if @stories do %>
            <.stories
              path={@path}
              stories={@stories}
              changeset={@changeset}
              page_state={@page_state}
            />
          <% end %>
          <%= if @inner_block do %>
            <%= render_slot(@inner_block) %>
          <% end %>
        </div>
      </div>
      <div class="sb-story-layout__sidebar" :if={@stories}>
        <.story_page_sidebar stories={@stories} is_story_doc_components={assigns[:story_doc_components]} />
      </div>
    </div>

    <.drawer_navigation path={@path} stories={@stories} changeset={@changeset} ui_changeset={@ui_changeset} navigation_topic_state={@navigation_topic_state} />
    """
  end

  # ------------------------------------------------------------------------------------
  # clipboard_button
  # ------------------------------------------------------------------------------------

  attr(:button_id, :string, required: true)
  attr(:clipboard_target, :string, required: true)

  def clipboard_button(assigns) do
    ~H"""
    <button class="copy-button" aria-label="copy" phx-hook="Clipboard" id={@button_id} data-clipboard-target={@clipboard_target}><svg xmlns="http://www.w3.org/2000/svg" height="24px" viewBox="0 0 24 24" width="24px" fill="currentColor"><path d="M0 0h24v24H0z" fill="none"></path><path d="M16 1H4c-1.1 0-2 .9-2 2v14h2V3h12V1zm3 4H8c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h11c1.1 0 2-.9 2-2V7c0-1.1-.9-2-2-2zm0 16H8V7h11v14z"></path></svg></button>
    """
  end

  # ------------------------------------------------------------------------------------
  # story
  # ------------------------------------------------------------------------------------

  attr(:story_id, :string, required: false)
  attr(:path, :string, required: true)
  attr(:title, :string, required: true)
  attr(:is_interactive, :boolean, default: false, required: false)
  attr(:raw, :string, default: nil)
  attr(:changeset, :map)
  attr(:page_state, :map, required: true)
  slot(:info, required: false)
  slot(:section, required: false)
  slot(:code, required: false)
  slot(:inner_block, required: true)

  def story(assigns) do
    story_id =
      assigns[:story_id] || "#{assigns.path}-#{assigns.title}" |> String.replace(~r/[\/ ]/, "")

    safe_story_id = Slug.slugify(story_id)
    page_state = assigns.page_state
    story_state = page_state[safe_story_id]
    show_source = !!story_state["source"]
    show_rendered = !!story_state["rendered"]

    code_button_class_default = "sb-raw color-bg-default color-fg-accent"
    code_button_class_active = "sb-raw color-fg-default color-bg-accent"

    assigns =
      assigns
      |> assign(:show_source, show_source)
      |> assign(:show_rendered, show_rendered)
      |> assign(:story_id, safe_story_id)
      |> assign(:code_id, "#{safe_story_id}-code")
      |> assign(:button_id, "#{safe_story_id}-button")
      |> assign(:clipboard_target, "##{safe_story_id}-code")
      |> assign(:code_button_class_default, code_button_class_default)
      |> assign(:code_button_class_active, code_button_class_active)

    ~H"""
    <div class="sb-story" id={Slug.slugify(@title)}>
      <.subhead>
        <%= @title %>
      </.subhead>
      <%= if @is_interactive do %>
      <.label is_success>Interactive</.label>
      <% end %>
      <%= if @info && @info !== [] do %>
        <.styled_html class="sb-story-doc__info"><%= render_slot(@info) %></.styled_html>
      <% end %>

      <div class="sb-component">
        <%= render_slot(@inner_block) %>
      </div>
      <%= if @raw do %>
        <div class="sb-code-examples">
          <div>
            <.code_button story_id={@story_id} key="source" is_active={@show_source}>
              Show code
            </.code_button>

            <%= if @show_source do %>
              <div class="sb-code-example">
                <pre class="makeup" id={@code_id}><%= @raw |> String.replace("__REMOVE__", "") |> format_heex() %></pre>
                <.clipboard_button button_id={@button_id} clipboard_target={@clipboard_target} />
              </div>
            <% end %>
          </div>
          <div>
            <.code_button story_id={@story_id} key="rendered" is_active={@show_rendered}>
              Show rendered
            </.code_button>

            <%= if @show_rendered do %>
              <div class="sb-code-example makeup">
                <%= render_slot(@inner_block) |> rendered_to_string() |> makeup_html()  %>
              </div>
            <% end %>
          </div>
        </div>
      <% end %>

      <%= if @section && @section !== [] do %>
        <.styled_html><%= render_slot(@section) %></.styled_html>
      <% end %>
      <%= if @code && @code !== [] do %>
        <div class="sb-code-example makeup">
          <%= render_slot(@code) |> rendered_to_string() |> makeup_html()  %>
        </div>
      <% end %>
    </div>
    """
  end

  # ------------------------------------------------------------------------------------
  # text
  # ------------------------------------------------------------------------------------

  attr(:path, :string, required: true)
  attr(:title, :string, required: true)

  slot :section,
    doc: """
    Text section
    """ do
    attr(:type, :string,
      values: ~w(text code),
      doc: """
      Section type
      """
    )

    attr(:id, :string,
      doc: """
      ID for code section.
      """
    )

    attr(:rest, :any)
  end

  def text(assigns) do
    allowed_slots = [:section]

    slots = Enum.filter(assigns, fn {key, value} -> key in allowed_slots end)

    get_code_ids = fn slot_id ->
      text_id =
        assigns[:text_id] ||
          "#{assigns.path}-#{assigns.title}-#{slot_id}" |> String.replace(~r/[\/ ]/, "")

      safe_text_id = Slug.slugify(text_id)

      [
        %{
          code_id: "#{safe_text_id}-code",
          button_id: "#{safe_text_id}-button",
          clipboard_target: "##{safe_text_id}-code"
        }
      ]
    end

    assigns =
      assigns
      |> assign(:slots, slots)

    ~H"""
    <div class="sb-story" id={Slug.slugify(@title)}>
      <.subhead>
        <%= @title %>
      </.subhead>

      <%= for slot <- @section do %>
        <%= if slot[:type] == "text" do %>
          <.styled_html><%= render_slot(slot) %></.styled_html>
        <% end %>
        <%= if slot[:type] == "code" do %>
          <div class="sb-code-example makeup">
          <%= for %{
            code_id: code_id,
            button_id: button_id,
            clipboard_target: clipboard_target
          } <- get_code_ids.(slot[:id]) do %>
              <pre class="makeup" id={code_id}><%= render_slot(slot) |> rendered_to_string() |> String.replace("__REMOVE__", "") |> String.replace("&lt;", "<") |> String.replace("&gt;", ">") |> String.replace("&quot;", "\"") |> format_heex() %></pre>
              <.clipboard_button button_id={button_id} clipboard_target={clipboard_target} />
            <% end %>
          </div>
        <% end %>
      <% end %>

    </div>
    """
  end

  # ------------------------------------------------------------------------------------
  # code
  # ------------------------------------------------------------------------------------

  attr(:lang, :string, required: true, values: ~w(elixir))
  slot(:inner_block, required: true)

  def code(assigns) do
    ~H"""
    <%= if @lang === "elixir" do %>
      <div class="sb-code-example">
      <pre class="makeup"><%= render_slot(@inner_block) |> rendered_to_string() |> String.replace("__REMOVE__", "") |> format_heex()  %></pre>
      </div>
    <% end %>
    """
  end

  # ------------------------------------------------------------------------------------
  # code_button
  # ------------------------------------------------------------------------------------

  attr(:is_active, :boolean, required: true)
  attr(:story_id, :string, required: true)
  attr(:key, :string, required: true)
  slot(:inner_block, required: true)

  def code_button(assigns) do
    class =
      AttributeHelpers.classnames([
        "sb-raw",
        !assigns.is_active && "color-bg-default",
        !assigns.is_active && "color-fg-subtle"
      ])

    attributes =
      AttributeHelpers.append_attributes([
        [class: class],
        [type: "button"],
        ["aria-selected": assigns.is_active],
        ["phx-click": "toggle_state"],
        ["phx-value-story-id": assigns.story_id],
        ["phx-value-key": assigns.key]
      ])

    assigns =
      assigns
      |> assign(:attributes, attributes)

    ~H"""
    <.button is_outline is_small {@attributes}>
      <%= render_slot(@inner_block) %>
    </.button>
    """
  end

  # ------------------------------------------------------------------------------------
  # stories
  # ------------------------------------------------------------------------------------

  attr(:path, :string, required: true)
  attr(:stories, :map, required: true)
  attr(:page_state, :map, required: true)
  attr(:changeset, :map)

  def stories(assigns) do
    render_story = fn story_fn, title, is_interactive, path, page_state, changeset ->
      assigns =
        assigns
        |> assign(:story_fn, story_fn)
        |> assign(:title, title)
        |> assign(:path, path)
        |> assign(:changeset, changeset)
        |> assign(:page_state, page_state)
        |> assign(:is_interactive, is_interactive)

      ~H"""
      <%= @story_fn.(assigns) %>
      """
    end

    assigns =
      assigns
      |> assign(:render_story, render_story)

    ~H"""
    <div class="sb-stories">
      <%= for %{story_fn: story_fn, title: title, is_interactive: is_interactive} <- @stories do %>
      <%= @render_story.(story_fn, title, is_interactive, @path, @page_state, @changeset) %>
      <% end %>
    </div>
    """
  end

  # ------------------------------------------------------------------------------------
  # story_page_links
  # ------------------------------------------------------------------------------------

  attr(:stories, :map, required: true)
  attr(:is_sub_group, :boolean, default: false)
  attr(:is_story_doc_components, :boolean, default: false)

  def story_page_links(assigns) do
    ~H"""
      <%= if @is_sub_group do %>
        <.action_list_item :for={%{title: title} <- @stories} is_sub_item>
          <:link patch={"##{Slug.slugify(title)}"} onclick="liveSocket.hooks.Drawer.select()">
            <%= title %>
          </:link>
        </.action_list_item>
      <% else %>
        <.action_list_section_divider>
          <:title>On this page</:title>
        </.action_list_section_divider>
        <.action_list_item>
          <:link patch="#top">
            Top of page
          </:link>
        </.action_list_item>
        <%= if @is_story_doc_components do %>
          <.action_list_item>
            <:link patch="#documentation">
              Documentation
            </:link>
          </.action_list_item>
          <.action_list_section_divider />
          <.action_list_section_divider>
            <:title>Stories</:title>
          </.action_list_section_divider>
        <% else %>
          <.action_list_section_divider />
        <% end %>
        <.action_list_item :for={%{title: title} <- @stories}>
          <:link patch={"##{Slug.slugify(title)}"}>
            <%= title %>
          </:link>
        </.action_list_item>
        <.action_list_section_divider />
        <%= if Enum.count(@stories) > 10 do %>
          <.action_list_item>
            <:link patch="#top">
              Top of page
            </:link>
          </.action_list_item>
        <% end %>
      <% end %>
    """
  end

  # ------------------------------------------------------------------------------------
  # story_page_sidebar
  # ------------------------------------------------------------------------------------

  attr(:stories, :map, required: true)
  attr(:is_story_doc_components, :boolean, required: true)

  def story_page_sidebar(assigns) do
    ~H"""
    <div class="sb-story-sidebar__outer">
      <.action_list class="sb-story-sidebar__menu">
      <.story_page_links stories={@stories} is_story_doc_components={@is_story_doc_components} />
      </.action_list>
    </div>
    """
  end

  defp format_heex(code) do
    code
    |> String.trim()
    |> Makeup.highlight_inner_html()
    |> HTML.raw()
  end

  defp makeup_html(code) do
    code
    |> String.trim()
    |> Phoenix.LiveView.HTMLFormatter.format([])
    |> Makeup.highlight()
    |> HTML.raw()
  end

  # ------------------------------------------------------------------------------------
  # story_doc
  # ------------------------------------------------------------------------------------

  attr(:components, :list, required: false)
  slot(:inner_block, required: false)

  def story_doc(assigns) do
    links =
      (assigns.components || [])
      |> Enum.map(&%{url: Config.doc_link_for_component(&1), label: &1})

    has_links? = Enum.count(links) > 0

    class =
      AttributeHelpers.classnames([
        "sb-story-doc",
        has_links? && "sb-story-doc--links"
      ])

    assigns =
      assigns
      |> assign(:links, links)
      |> assign(:has_links?, has_links?)
      |> assign(:class, class)

    ~H"""
    <div class={@class} id="documentation">
      <%= if @inner_block && @inner_block !== [] do %>
        <%= render_slot(@inner_block) %>
      <% end %>
      <%= if @has_links? do %>
        <div class="sb-story-doc__links color-border-subtle border-top">
        <.action_list is_full_bleed class="col-sm-12 col-md-7 col-lg-5">
          <.action_list_section_divider>
            <:title>
              Documentation
            </:title>
          </.action_list_section_divider>
          <%= for %{url: url, label: label} <- @links do %>
            <.action_list_item>
              <:link href={url} target="_blank" class="text-mono"><%= label %></:link>
              <:leading_visual>
              <.octicon name="file-16" />
            </:leading_visual>
            </.action_list_item>
          <% end %>
        </.action_list>
        </div>
      <% end %>
    </div>
    """
  end

  # ------------------------------------------------------------------------------------
  # theme_menu
  # ------------------------------------------------------------------------------------

  attr(:theme_state, :map, required: true)
  attr(:default_theme_state, :map, required: true)
  attr(:ui_changeset, :map, required: true)

  attr(:rest, :global,
    doc: """
    Additional HTML attributes added to the outer element.
    """
  )

  def theme_menu(assigns) do
    rest =
      assigns_to_attributes(assigns.rest, [
        :theme_state,
        :default_theme_state
      ])

    assigns = assigns |> assign(:rest, rest)

    ~H"""
    <.theme color_mode="dark" dark_theme="dark_high_contrast" {@rest}>
      <.form :let={f} for={@ui_changeset} phx-change="update_ui">
        <.action_menu is_fast is_right_aligned class="sb-theme-menu" menu_theme={@theme_state} form={f} field={:theme_menu_open}>
          <:toggle>
            <.octicon name="sun-16" />
          </:toggle>
          <.theme_menu_options default_theme_state={@default_theme_state} theme_state={@theme_state} />
        </.action_menu>
      </.form>
    </.theme>
    """
  end
end
