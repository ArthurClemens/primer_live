defmodule PrimerLive.TestComponents.FormControlTest do
  @moduledoc false

  use PrimerLive.TestBase
  alias PrimerLive.TestHelpers.Repo.Users

  test "Called without options: should render the component" do
    assigns = %{}

    run_test(
      ~H"""
      <.form_control>inputs</.form_control>
      """,
      __ENV__
    )
  end

  test "Attribute: form and field (atoms)" do
    assigns = %{}

    run_test(
      ~H"""
      <.form_control form={:user} field={:first_name}>inputs</.form_control>
      """,
      __ENV__
    )
  end

  test "Attribute: field as string" do
    assigns = %{}

    run_test(
      ~H"""
      <.form_control form={:user} field="first_name">inputs</.form_control>
      """,
      __ENV__
    )
  end

  test "Attribute: is_hide_label" do
    assigns = %{}

    run_test(
      ~H"""
      <.form_control is_hide_label>inputs</.form_control>
      """,
      __ENV__
    )
  end

  test "Attribute: is_disabled" do
    assigns = %{}

    run_test(
      ~H"""
      <.form_control is_disabled>inputs</.form_control>
      """,
      __ENV__
    )
  end

  test "Attribute: is_full_width" do
    assigns = %{}

    run_test(
      ~H"""
      <.form_control is_full_width>inputs</.form_control>
      """,
      __ENV__
    )
  end

  test "Attribute: required_marker" do
    changeset = Users.init()

    assigns = %{
      changeset: changeset,
      field: :first_name
    }

    run_test(
      ~H"""
      <.form :let={f} for={@changeset}>
        <.form_control form={f} field={@field}>inputs</.form_control>
      </.form>

      <.form :let={f} for={@changeset}>
        <.form_control form={f} field={@field} required_marker="">inputs</.form_control>
      </.form>

      <.form :let={f} for={@changeset}>
        <.form_control form={f} field={@field} required_marker="required">inputs</.form_control>
      </.form>
      """,
      __ENV__
    )
  end

  test "Extra attributes" do
    assigns = %{}

    run_test(
      ~H"""
      <.form_control dir="rtl">inputs</.form_control>
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
        <.form_control
          class="my-form-control"
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
        </.form_control>
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
        <.form_control form={f} field={@field}>
          <.checkbox form={f} field={@field} checked_value="admin" />
          <.checkbox form={f} field={@field} checked_value="editor" />
        </.form_control>
      </.form>
      """,
      __ENV__
    )
  end
end
