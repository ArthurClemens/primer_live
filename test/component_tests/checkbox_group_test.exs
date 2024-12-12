defmodule PrimerLive.TestComponents.CheckboxGroupTest do
  @moduledoc false

  use PrimerLive.TestBase
  alias PrimerLive.TestHelpers.Repo.Todos

  test "Simple group" do
    assigns = %{}

    run_test(
      ~H"""
      <form>
        <.checkbox_group>
          <.checkbox name="roles[]" checked_value="admin" />
          <.checkbox name="roles[]" checked_value="editor" />
        </.checkbox_group>
      </form>
      """,
      __ENV__
    )
  end

  test "Disabled" do
    assigns = %{}

    run_test(
      ~H"""
      <form>
        <.checkbox_group is_disabled>
          <.checkbox name="roles[]" checked_value="admin" />
          <.checkbox name="roles[]" checked_value="editor" />
        </.checkbox_group>
      </form>
      """,
      __ENV__
    )
  end

  test "Caption" do
    assigns = %{}

    run_test(
      ~H"""
      <form>
        <.checkbox_group label="Role" caption="Select one">
          <.checkbox name="role-caption[]" checked_value="admin" />
          <.checkbox name="role-caption[]" checked_value="editor" />
        </.checkbox_group>
      </form>
      """,
      __ENV__
    )
  end

  test "Derived label" do
    changeset = Todos.init()
    options = Todos.status_options()
    values = changeset.changes |> Map.get(:statuses) || []

    assigns = %{
      changeset: changeset,
      options: options,
      values: values,
      field: :statuses
    }

    run_test(
      ~H"""
      <.form :let={f} for={@changeset}>
        <.checkbox_group form={f} field={@field}>
          <.checkbox_in_group
            :for={{_label, value} <- @options}
            form={f}
            field={@field}
            checked_value={value}
          />
        </.checkbox_group>
      </.form>
      """,
      __ENV__
    )
  end

  test "Custom label" do
    changeset = Todos.init()
    options = Todos.status_options()
    values = changeset.changes |> Map.get(:statuses) || []

    assigns = %{
      changeset: changeset,
      options: options,
      values: values,
      field: :statuses
    }

    run_test(
      ~H"""
      <.form :let={f} for={@changeset}>
        <.checkbox_group form={f} field={@field}>
          <.checkbox_in_group
            :for={{label, value} <- @options}
            form={f}
            field={@field}
            checked_value={value}
          >
            <:label>
              {label |> String.downcase()}
            </:label>
          </.checkbox_in_group>
        </.checkbox_group>
      </.form>
      """,
      __ENV__
    )
  end

  test "Default error" do
    changeset = Todos.init()
    options = Todos.status_options()
    values = changeset.changes |> Map.get(:statuses) || []

    form = %Phoenix.HTML.Form{
      impl: Phoenix.HTML.FormData.Ecto.Changeset,
      id: "user",
      name: "user",
      params: %{"statuses" => ""},
      source: %Ecto.Changeset{changeset | action: :validate}
    }

    assigns = %{
      options: options,
      values: values,
      field: :statuses,
      form: form
    }

    run_test(
      ~H"""
      <.checkbox_group form={@form} field={@field} label="Status" caption="Pick any of these choices">
        <%= for {label, value} <- @options do %>
          <.checkbox_in_group
            form={@form}
            field={@field}
            checked_value={value}
            checked={value in @values}
          >
            <:label>
              {label}
            </:label>
          </.checkbox_in_group>
        <% end %>
      </.checkbox_group>
      """,
      __ENV__
    )
  end
end
