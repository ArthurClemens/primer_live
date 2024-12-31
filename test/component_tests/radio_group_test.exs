defmodule PrimerLive.TestComponents.RadioGroupTest do
  @moduledoc false

  use PrimerLive.TestBase
  alias PrimerLive.TestHelpers.Repo.Todos

  test "Simple group" do
    assigns = %{}

    run_test(
      ~H"""
      <form>
        <.radio_group>
          <.radio_button name="role" value="admin" />
          <.radio_button name="role" value="editor" />
        </.radio_group>
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
        <.radio_group is_disabled>
          <.radio_button name="role" value="admin" />
          <.radio_button name="role" value="editor" />
        </.radio_group>
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
        <.radio_group label="Role" caption="Select one">
          <.radio_button name="role-caption" value="admin" />
          <.radio_button name="role-caption" value="editor" />
        </.radio_group>
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
        <.radio_group form={f} field={@field}>
          <.radio_button
            :for={{_label, value} <- @options}
            form={f}
            field={@field}
            value={value}
            id={value <> "-derived-label"}
          />
        </.radio_group>
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
        <.radio_group form={f} field={@field}>
          <.radio_button
            :for={{label, value} <- @options}
            form={f}
            field={@field}
            value={value}
            id={value <> "-custom-label"}
          >
            <:label>
              {label |> String.downcase()}
            </:label>
          </.radio_button>
        </.radio_group>
      </.form>
      """,
      __ENV__
    )
  end

  test "Default error" do
    changeset = Todos.init()

    validate_changeset = %Ecto.Changeset{
      changeset
      | action: :validate,
        changes: %{statuses: nil}
    }

    options = Todos.status_options()
    values = changeset.changes |> Map.get(:statuses) || []

    assigns = %{
      changeset: validate_changeset,
      options: options,
      values: values,
      field: :statuses
    }

    run_test(
      ~H"""
      <.form :let={f} for={@changeset}>
        <.radio_group form={f} field={@field} caption="Select one">
          <%= for {label, value} <- @options do %>
            <.radio_button form={f} field={@field} value={value} id={value <> "-default-error"}>
              <:label>
                {label}
              </:label>
            </.radio_button>
          <% end %>
        </.radio_group>
      </.form>
      """,
      __ENV__
    )
  end
end
