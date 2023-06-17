defmodule PrimerLiveTestWeb.ActionListLive do
  use PrimerLiveTestWeb, :live_view
  use Phoenix.Component
  use PrimerLive

  import PrimerLiveTestWeb.TestComponents

  alias PrimerLiveTest.Repo

  def mount(_params, _url, socket) do
    changeset = Repo.init_job_description()

    socket =
      socket
      |> assign(:changeset, changeset)

    {:ok, socket}
  end

  def render(assigns) do
    tests = [
      %{title: "Basic", test_fn: &test_basic/1},
      %{title: "Single select", test_fn: &test_single_select/1},
      %{title: "Multiple select", test_fn: &test_multiple_select/1}
    ]

    assigns =
      assigns
      |> assign(:tests, tests)

    ~H"""
    <.test_page tests={@tests} title="action_list" changeset={@changeset} />
    """
  end

  defp test_basic(assigns) do
    ~H"""
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
    """
  end

  defp test_single_select(assigns) do
    values = assigns.changeset.changes |> Map.get(:roles) || []
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
    <div class="my-3" data-testid="single-select-value">
      Selected: <%= @selected_text %>
    </div>
    <div class="col-12 col-md-6">
      <.form :let={f} for={@changeset} phx-change="validate" phx-submit="save" phx-value-role={@current_role}>
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
    """
  end

  defp test_multiple_select(assigns) do
    values = assigns.changeset.changes |> Map.get(:roles) || []
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
    <div class="my-3" data-testid="multiple-select-value">
      Selected: <%= @selected_text %>
    </div>
    <div class="col-12 col-md-6">
      <.form :let={f} for={@changeset} phx-change="validate" phx-submit="save">
        <.action_list>
          <%= for {label, value} <- @options do %>
            <.action_list_item
              form={f}
              field={:roles}
              checked_value={value}
              is_multiple_select
              is_selected={value in @values}
              input_id={"multiple-select-" <> value}
            >
              <%= label %>
            </.action_list_item>
          <% end %>
        </.action_list>
      </.form>
    </div>
    """
  end

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
