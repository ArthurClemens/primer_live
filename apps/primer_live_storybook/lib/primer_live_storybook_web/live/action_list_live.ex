defmodule PrimerLiveStorybookWeb.ActionListLive do
  use PrimerLiveStorybookWeb.Helpers.StoryPage,
    page_title: "Action List",
    path: "/action_list"

  # def mount(params, session, socket) do
  #   changeset = Repo.init_job_description()

  #   socket =
  #     socket
  #     |> PrimerLive.Theme.add_to_socket(
  #       session,
  #       %{
  #         color_mode: "light",
  #         light_theme: "light",
  #         dark_theme: "dark"
  #       }
  #     )
  #     |> NavigationTopicHelpers.add_to_socket(session)
  #     |> assign(:page_title, @page_title)
  #     |> assign(:path, @path)
  #     |> assign(:changeset, changeset)
  #     |> assign(:ui_changeset, nil)
  #     |> assign(:page_state, %{})

  #   {:ok, socket}
  # end

  def handle_params(_params, _url, socket) do
    changeset = Repo.init_job_description()
    IO.inspect(changeset, label: "handle_params changeset")

    socket =
      socket
      |> assign(:changeset, changeset)

    {:noreply, socket}
  end

  def render(assigns) do
    assigns =
      assigns
      |> assign(:stories, [
        %{title: "Single select", story_fn: &story_single_select/1},
        %{title: "Basic", story_fn: &story_basic/1}
      ])
      |> assign(:story_doc_components, ["action_list"])

    ~H"""
    <.story_page
      page_title={@page_title}
      path={@path}
      theme_state={@theme_state}
      default_theme_state={@default_theme_state}
      navigation_topic_state={@navigation_topic_state}
      ui_changeset={@ui_changeset}
    >
      <.story_page_content
        page_title={@page_title}
        path={@path}
        story_doc_components={@story_doc_components}
        stories={@stories}
        page_state={@page_state}
        navigation_topic_state={@navigation_topic_state}
      />
    </.story_page>
    """
  end

  defp story_basic(assigns) do
    ~H"""
    <.story
    page_state={@page_state}
    path={@path}
    title={@title}
    raw={~S'''
    <div class="col-12 col-md-6">
      <.action_list>
        <.action_list_item data-testid="test-basic-item-1">
          Item 1
        </.action_list_item>
        <.action_list_item data-testid="test-basic-item-2">
          Item 2
        </.action_list_item>
        <.action_list_item data-testid="test-basic-item-3">
          Item 3
        </.action_list_item>
      </.action_list>
    </div>
    '''}>
    <div class="col-12 col-md-6">
      <.action_list>
        <.action_list_item data-testid="test-basic-item-1">
          Item 1
        </.action_list_item>
        <.action_list_item data-testid="test-basic-item-2">
          Item 2
        </.action_list_item>
        <.action_list_item data-testid="test-basic-item-3">
          Item 3
        </.action_list_item>
      </.action_list>
    </div>
    </.story>
    """
  end

  defp story_single_select(assigns) do
    values =
      if assigns.changeset[:changes],
        do: assigns.changeset.changes |> Map.get(:roles) || [],
        else: []

    IO.inspect(assigns.changeset, label: "assigns.changeset")

    current_role = List.first(values) || ""
    options = Repo.role_options()
    label_lookup = options |> Enum.map(fn {label, value} -> {value, label} end) |> Enum.into(%{})
    selected_labels = values |> Enum.map(&Map.get(label_lookup, &1))

    selected_text =
      if Enum.count(selected_labels) > 0,
        do: selected_labels |> Enum.join(", "),
        else: "-"

    assigns =
      assigns
      |> assign(:options, options)
      |> assign(:values, values)
      |> assign(:current_role, current_role)
      |> assign(:selected_text, selected_text)

    ~H"""
    <.story
    page_state={@page_state}
    path={@path}
    title={@title}
    is_interactive
    raw={~S'''
    XXX
    '''}>
    <div class="my-3" data-testid="single-select-value">
      Selected: <%= @selected_text %>
    </div>
    <div class="col-12 col-md-6">
      <.form :let={f} for={@changeset} phx-change="validate" phx-submit="save" phx-value-role={@current_role} target={@myself}>
        <.action_list>
          <%= for {label, value} <- @options do %>
            <.action_list_item
              form={f}
              field={:roles}
              checked_value={value}
              is_single_select
              is_selected={value in @values}
            >
              <%= label %>
            </.action_list_item>
          <% end %>
        </.action_list>
      </.form>
    </div>
    </.story>
    """
  end

  # Parameters: %{"_target" => ["roles"], "role" => "", "roles" => ["false", "admin", "false", "editor", "false"]}

  def handle_event(
        "validate",
        %{"role" => role, "job_description" => params},
        socket
      ) do
    valid_roles = params |> Map.get("roles") |> Enum.reject(&(&1 === role))
    new_params = params |> Map.put("roles", valid_roles)

    changeset =
      Repo.empty_job_description()
      |> Repo.change_job_description(new_params)
      |> Map.put(:action, :validate)

    socket =
      socket
      |> assign(:changeset, changeset)

    {:noreply, socket}
  end

  def handle_event(
        "validate",
        %{"job_description" => params},
        socket
      ) do
    changeset =
      Repo.empty_job_description()
      |> Repo.change_job_description(params)
      |> Map.put(:action, :validate)

    socket =
      socket
      |> assign(:changeset, changeset)

    {:noreply, socket}
  end

  def handle_event("validate", _params, socket) do
    {:noreply, socket}
  end
end
