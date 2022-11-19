defmodule PrimerLive.TestComponents.TextareaTest do
  use ExUnit.Case
  use PrimerLive
  import PrimerLive.Helpers.TestHelpers

  import Phoenix.Component
  import Phoenix.LiveViewTest

  @default_form %Phoenix.HTML.Form{
    id: "user",
    name: "user",
    params: %{"first_name" => ""},
    source: %Ecto.Changeset{
      action: :validate,
      changes: %{},
      errors: [
        first_name: {"can't be blank", [validation: :required]}
      ],
      data: nil,
      valid?: false
    }
  }

  test "Called without options: should render the component" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.textarea />
           """)
           |> format_html() ==
             """
             <textarea class="form-control" id="_" name="[]"></textarea>
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
             <textarea class="form-control input-lg" id="_" name="[]"></textarea>
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
             <textarea class="form-control input-sm" id="_" name="[]"></textarea>
             """
             |> format_html()
  end

  test "Attribute: class" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.textarea class="x" />
           """)
           |> format_html() ==
             """
             <textarea class="form-control x" id="_" name="[]"></textarea>
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
             <div class="form-group">
             <div class="form-group-header"><label for="user_first_name">First name</label></div>
             <div class="form-group-body"><textarea class="form-control" id="user_first_name" name="first_name"></textarea></div>
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
             <div class="form-group">
             <div class="form-group-header"><label for="user_first_name">Some label</label></div>
             <div class="form-group-body"><textarea class="form-control" id="user_first_name" name="user[first_name]"></textarea></div>
             </div>
             """
             |> format_html()
  end

  test "Attribute: form_group (validation_message)" do
    assigns = %{
      form: @default_form
    }

    assert rendered_to_string(~H"""
           <.textarea
             form={@form}
             field={:first_name}
             form_group={
               %{
                 validation_message: fn field_state ->
                   if !field_state.valid?, do: "Please enter your first name"
                 end
               }
             }
           />
           """)
           |> format_html() ==
             """
             <div class="form-group errored">
             <div class="form-group-header"><label for="user_first_name">First name</label></div>
             <div class="form-group-body"><textarea aria-describedby="user_first_name-validation" class="form-control" id="user_first_name" name="user[first_name]"></textarea>
             <div class="FormControl-inlineValidation FormControl-inlineValidation--error" id="user_first_name-validation"><svg class="octicon" xmlns="http://www.w3.org/2000/svg" width="12" height="12" viewBox="0 0 12 12">
             <path fill-rule="evenodd" d="M4.855.708c.5-.896 1.79-.896 2.29 0l4.675 8.351a1.312 1.312 0 01-1.146 1.954H1.33A1.312 1.312 0 01.183 9.058L4.855.708zM7 7V3H5v4h2zm-1 3a1 1 0 100-2 1 1 0 000 2z"></path>
             </svg><span>Please enter your first name</span></div>
             </div>
             </div>
             """
             |> format_html()
  end
end
