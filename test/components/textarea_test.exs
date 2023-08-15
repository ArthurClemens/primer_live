defmodule PrimerLive.TestComponents.TextareaTest do
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

  test "Called without options: should render the component" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.textarea />
           """)
           |> format_html() ==
             """
             <textarea class="FormControl-textarea FormControl-medium"></textarea>
             """
             |> format_html()
  end

  test "Attribute: is_large" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.textarea is_large />
           """)
           |> format_html() ==
             """
             <textarea class="FormControl-textarea FormControl-large"></textarea>
             """
             |> format_html()
  end

  test "Attribute: is_small" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.textarea is_small />
           """)
           |> format_html() ==
             """
             <textarea class="FormControl-textarea FormControl-small"></textarea>
             """
             |> format_html()
  end

  test "Attribute: class" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.textarea class="my-textarea" />
           """)
           |> format_html() ==
             """
             <textarea class="FormControl-textarea FormControl-medium my-textarea"></textarea>
             """
             |> format_html()
  end

  test "Attribute: is_form_group" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.textarea form={:user} name="first_name" is_form_group />
           """)
           |> format_html() ==
             """
             <div class="FormControl form-group">
             <div class="form-group-header"><label class="FormControl-label" for="user_first_name">First name</label></div>
             <textarea class="FormControl-textarea FormControl-medium" id="user_first_name" name="user[first_name]"></textarea>
             </div>
             """
             |> format_html()
  end

  test "Attribute: form_group (label)" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.textarea
             form={:user}
             field="first_name"
             form_group={
               %{
                 label: "Some label"
               }
             }
           />
           """)
           |> format_html() ==
             """
             <div class="FormControl form-group">
             <div class="form-group-header"><label class="FormControl-label" for="user_first_name">Some label</label></div>
             <textarea class="FormControl-textarea FormControl-medium" id="user_first_name" name="user[first_name]"></textarea>
             </div>
             """
             |> format_html()
  end

  test "Attribute: validation_message" do
    assigns = %{
      form: %{@default_form | source: @error_changeset}
    }

    assert rendered_to_string(~H"""
           <.textarea
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
             <div class="pl-invalid" phx-feedback-for="user[first_name]"><textarea aria-describedby="user_first_name-validation"
             class="FormControl-textarea FormControl-medium" id="user_first_name" invalid="" name="user[first_name]"></textarea>
             </div>
             <div class="FormControl-inlineValidation FormControl-inlineValidation--error" id="user_first_name-validation"
             phx-feedback-for="user[first_name]"><svg class="octicon" xmlns="http://www.w3.org/2000/svg" width="12" height="12"
             viewBox="0 0 12 12">STRIPPED_SVG_PATHS</svg><span>Please enter your first name</span></div>
             """
             |> format_html()
  end
end
