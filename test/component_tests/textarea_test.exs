defmodule PrimerLive.TestComponents.TextareaTest do
  @moduledoc false

  use PrimerLive.TestBase
  alias PrimerLive.TestHelpers.Repo.Users

  test "Called without options: should render the component" do
    assigns = %{}

    run_test(
      ~H"""
      <.textarea />
      """,
      __ENV__
    )
  end

  test "Attribute: is_large" do
    assigns = %{}

    run_test(
      ~H"""
      <.textarea is_large />
      """,
      __ENV__
    )
  end

  test "Attribute: is_small" do
    assigns = %{}

    run_test(
      ~H"""
      <.textarea is_small />
      """,
      __ENV__
    )
  end

  test "Attribute: class" do
    assigns = %{}

    run_test(
      ~H"""
      <.textarea class="my-textarea" />
      """,
      __ENV__
    )
  end

  test "Attribute: caption" do
    changeset = Users.init()

    assigns = %{
      changeset: changeset,
      field: :first_name
    }

    run_test(
      ~H"""
      <.form :let={f} for={@changeset}>
        <.textarea form={f} field={@field} caption="Caption 1" />
      </.form>
      <.form :let={f} for={@changeset}>
        <.textarea
          form={f}
          field={@field}
          caption={
            fn ->
              ~H'''
              Caption 2
              '''
            end
          }
          is_form_control
        />
      </.form>
      <.form :let={f} for={@changeset}>
        <.textarea
          form={f}
          field={@field}
          caption={
            fn field_state ->
              if !field_state.valid?,
                # Hide this text because the error validation message will show similar content
                do: nil
            end
          }
        />
      </.form>
      """,
      __ENV__
    )
  end

  test "Attribute: is_form_control" do
    assigns = %{}

    run_test(
      ~H"""
      <.textarea form={:user} name="first_name" is_form_control />
      """,
      __ENV__
    )
  end

  test "Attribute: form_control (label)" do
    assigns = %{}

    run_test(
      ~H"""
      <.textarea
        form={:user}
        field="first_name"
        form_control={
          %{
            label: "Some label"
          }
        }
      />
      """,
      __ENV__
    )
  end

  test "Attribute: validation_message" do
    changeset = Users.init()

    validate_changeset = %Ecto.Changeset{
      changeset
      | action: :validate,
        changes: %{first_name: nil}
    }

    assigns = %{
      changeset: validate_changeset,
      field: :first_name
    }

    run_test(
      ~H"""
      <.form :let={f} for={@changeset}>
        <.textarea
          form={f}
          field={@field}
          validation_message={
            fn field_state ->
              if !field_state.valid?, do: "Please enter your first name"
            end
          }
        />
      </.form>
      """,
      __ENV__
    )
  end

  test "Attribute: classes" do
    changeset = Users.init()

    assigns = %{
      changeset: changeset,
      field: :first_name,
      classes: %{
        input: "input-x",
        validation_message: "validation_message-x",
        caption: "caption-x"
      },
      form_control_attrs: %{
        classes: %{
          control: "control-x",
          group: "group-x",
          header: "header-x",
          label: "label-x"
        }
      },
      class: "my-text-input"
    }

    run_test(
      ~H"""
      <.form :let={f} for={@changeset}>
        <.textarea
          classes={@classes}
          form_control={@form_control_attrs}
          class={@class}
          caption={fn -> "Caption" end}
          form={f}
          field={@field}
        />
      </.form>
      """,
      __ENV__
    )
  end
end
