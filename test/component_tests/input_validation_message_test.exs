defmodule PrimerLive.TestComponents.InputValidationMessageTest do
  @moduledoc false

  use PrimerLive.TestBase

  @default_form %Phoenix.HTML.Form{
    impl: Phoenix.HTML.FormData.Ecto.Changeset,
    id: "user",
    name: "user",
    params: %{"first_name" => ""},
    source: %Ecto.Changeset{
      action: :validate,
      changes: %{},
      errors: [],
      data: nil,
      valid?: true
    }
  }

  @error_changeset %Ecto.Changeset{
    action: :validate,
    changes: %{},
    errors: [
      first_name: {"can't be blank", [validation: :required]}
    ],
    data: nil,
    valid?: false
  }

  test "Without form" do
    assigns = %{}

    run_test(
      ~H"""
      <.input_validation_message />
      """,
      __ENV__
    )
  end

  test "Default validation message" do
    assigns = %{
      form: %{@default_form | source: @error_changeset}
    }

    run_test(
      ~H"""
      <.input_validation_message form={@form} field={:first_name} />
      """,
      __ENV__
    )
  end

  test "Attribute: validation_message (custom error message)" do
    assigns = %{
      form: %{@default_form | source: @error_changeset}
    }

    run_test(
      ~H"""
      <.input_validation_message
        form={@form}
        field={:first_name}
        validation_message={
          fn field_state ->
            if !field_state.valid?, do: "Please enter your first name"
          end
        }
      />
      """,
      __ENV__
    )
  end

  test "Attribute: is_multiple" do
    assigns = %{
      form: %{@default_form | source: @error_changeset}
    }

    run_test(
      ~H"""
      <.input_validation_message
        form={@form}
        field={:first_name}
        validation_message={
          fn field_state ->
            if !field_state.valid?, do: "Please enter your first name"
          end
        }
        is_multiple
      />
      """,
      __ENV__
    )
  end

  test "Attribute: validation_message (custom success message)" do
    assigns = %{
      form: %{
        @default_form
        | source: @default_form.source,
          params: %{"first_name" => "anna"}
      }
    }

    run_test(
      ~H"""
      <.input_validation_message
        form={@form}
        field={:first_name}
        validation_message={
          fn field_state ->
            if field_state.valid?, do: "Available!"
          end
        }
      />
      """,
      __ENV__
    )
  end

  test "Attribute: validation_message_id" do
    assigns = %{
      form: %{@default_form | source: @error_changeset}
    }

    run_test(
      ~H"""
      <.input_validation_message form={@form} field={:first_name} validation_message_id="xxx" />
      """,
      __ENV__
    )
  end

  test "Attribute: class" do
    assigns = %{
      form: %{@default_form | source: @error_changeset}
    }

    run_test(
      ~H"""
      <.input_validation_message form={@form} field={:first_name} class="my-input_validation_message" />
      """,
      __ENV__
    )
  end
end
