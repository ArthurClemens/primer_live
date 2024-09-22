defmodule PrimerLive.TestComponents.FormGroupDeprecatedTest do
  @moduledoc false

  use PrimerLive.TestBase
  alias PrimerLive.TestHelpers.Repo.Users

  test "Called without options : should render the component" do
    assigns = %{}

    run_test(
      ~H"""
      <.form_group>inputs</.form_group>
      """,
      __ENV__
    )
  end

  test "Attribute: form and field (atoms)" do
    assigns = %{}

    run_test(
      ~H"""
      <.form_group form={:user} field={:first_name}>inputs</.form_group>
      """,
      __ENV__
    )
  end

  test "Attribute: field as string" do
    assigns = %{}

    run_test(
      ~H"""
      <.form_group form={:user} field="first_name">inputs</.form_group>
      """,
      __ENV__
    )
  end

  test "Attribute: is_hide_label" do
    assigns = %{}

    run_test(
      ~H"""
      <.form_group is_hide_label>inputs</.form_group>
      """,
      __ENV__
    )
  end

  test "Attribute: is_disabled" do
    assigns = %{}

    run_test(
      ~H"""
      <.form_group is_disabled>inputs</.form_group>
      """,
      __ENV__
    )
  end

  test "Extra attributes" do
    assigns = %{}

    run_test(
      ~H"""
      <.form_group dir="rtl">inputs</.form_group>
      """,
      __ENV__
    )
  end

  test "Classes" do
    changeset = Users.init()

    assigns = %{
      changeset: changeset,
      field: :first_name
    }

    run_test(
      ~H"""
      <.form :let={f} for={@changeset}>
        <.form_group
          class="my-form-group"
          classes={
            %{
              control: "control-x",
              group: "group-x",
              header: "header-x",
              label: "label-x"
            }
          }
          form={f}
          field={@field}
        >
          inputs
        </.form_group>
      </.form>
      """,
      __ENV__
    )
  end

  test "Checkboxes" do
    changeset = Users.init()

    assigns = %{
      changeset: changeset,
      field: :available_for_hire
    }

    run_test(
      ~H"""
      <.form :let={f} for={@changeset}>
        <.form_group form={f} field={@field}>
          <.checkbox form={f} field={@field} checked_value="admin" />
          <.checkbox form={f} field={@field} checked_value="editor" />
        </.form_group>
      </.form>
      """,
      __ENV__
    )
  end
end
