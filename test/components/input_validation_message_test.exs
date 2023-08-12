defmodule PrimerLive.TestComponents.InputValidationMessageTest do
  use ExUnit.Case
  use PrimerLive
  import PrimerLive.Helpers.TestHelpers

  import Phoenix.Component
  import Phoenix.LiveViewTest

  @default_form %Phoenix.HTML.Form{
    impl: Phoenix.HTML.FormData.Atom,
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

    assert rendered_to_string(~H"""
           <.input_validation_message />
           """)
           |> format_html() == ""
  end

  test "Default validation message" do
    assigns = %{
      form: %{@default_form | source: @error_changeset}
    }

    assert rendered_to_string(~H"""
           <.input_validation_message form={@form} field={:first_name} />
           """)
           |> format_html() ==
             """
             <div class="FormControl-inlineValidation FormControl-inlineValidation--error" id="user_first_name-validation" phx-feedback-for="user[first_name]">
             <svg class="octicon" xmlns="http://www.w3.org/2000/svg" width="12" height="12" viewBox="0 0 12 12">STRIPPED_SVG_PATHS</svg>
             <span>can&#39;t be blank</span>
             </div>
             """
             |> format_html()
  end

  test "Attribute: validation_message (custom error message)" do
    assigns = %{
      form: %{@default_form | source: @error_changeset}
    }

    assert rendered_to_string(~H"""
           <.input_validation_message
             form={@form}
             field={:first_name}
             validation_message={
               fn field_state ->
                 if !field_state.valid?, do: "Please enter your first name"
               end
             }
           />
           """)
           |> format_html() ==
             """
             <div class="FormControl-inlineValidation FormControl-inlineValidation--error" id="user_first_name-validation" phx-feedback-for="user[first_name]">
             <svg class="octicon" xmlns="http://www.w3.org/2000/svg" width="12" height="12" viewBox="0 0 12 12">STRIPPED_SVG_PATHS</svg>
             <span>Please enter your first name</span>
             </div>
             """
             |> format_html()
  end

  test "Attribute: is_multiple" do
    assigns = %{
      form: %{@default_form | source: @error_changeset}
    }

    assert rendered_to_string(~H"""
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
           """)
           |> format_html() ==
             """
             <div class="FormControl-inlineValidation FormControl-inlineValidation--error" id="user_first_name-validation" phx-feedback-for="user[first_name][]">
             <svg class="octicon" xmlns="http://www.w3.org/2000/svg" width="12" height="12" viewBox="0 0 12 12">STRIPPED_SVG_PATHS</svg>
             <span>Please enter your first name</span>
             </div>
             """
             |> format_html()
  end

  test "Attribute: validation_message (custom success message)" do
    assigns = %{
      form: %{
        @default_form
        | source: @default_form.source,
          params: %{"first_name" => "anna"}
      }
    }

    assert rendered_to_string(~H"""
           <.input_validation_message
             form={@form}
             field={:first_name}
             validation_message={
               fn field_state ->
                 if field_state.valid?, do: "Available!"
               end
             }
           />
           """)
           |> format_html() ==
             """
             <div class="FormControl-inlineValidation FormControl-inlineValidation--success" id="user_first_name-validation" phx-feedback-for="user[first_name]">
             <svg class="octicon" xmlns="http://www.w3.org/2000/svg" width="12" height="12" viewBox="0 0 12 12">STRIPPED_SVG_PATHS</svg>
             <span>Available!</span>
             </div>
             """
             |> format_html()
  end

  test "Attribute: validation_message_id" do
    assigns = %{
      form: %{@default_form | source: @error_changeset}
    }

    assert rendered_to_string(~H"""
           <.input_validation_message form={@form} field={:first_name} validation_message_id="xxx" />
           """)
           |> format_html() ==
             """
             <div class="FormControl-inlineValidation FormControl-inlineValidation--error" id="xxx" phx-feedback-for="user[first_name]">
             <svg class="octicon" xmlns="http://www.w3.org/2000/svg" width="12" height="12" viewBox="0 0 12 12">STRIPPED_SVG_PATHS</svg>
             <span>can&#39;t be blank</span>
             </div>
             """
             |> format_html()
  end

  test "Attribute: class" do
    assigns = %{
      form: %{@default_form | source: @error_changeset}
    }

    assert rendered_to_string(~H"""
           <.input_validation_message form={@form} field={:first_name} class="my-input_validation_message" />
           """)
           |> format_html() ==
             """
             <div class="FormControl-inlineValidation FormControl-inlineValidation--error my-input_validation_message" id="user_first_name-validation" phx-feedback-for="user[first_name]">
             <svg class="octicon" xmlns="http://www.w3.org/2000/svg" width="12" height="12" viewBox="0 0 12 12">STRIPPED_SVG_PATHS</svg>
             <span>can&#39;t be blank</span>
             </div>
             """
             |> format_html()
  end
end
