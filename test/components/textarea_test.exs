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

  test "Attribute: caption" do
    assigns = %{
      form: %{@default_form | source: @error_changeset}
    }

    assert rendered_to_string(~H"""
           <.textarea caption={fn -> "Caption" end} />
           <.textarea caption={fn -> "Caption" end} is_form_control />
           <.textarea caption={
             fn field_state ->
               if !field_state.valid?,
                 # Hide this text because the error validation message will show similar content
                 do: nil
             end
           } />
           """)
           |> format_html() ==
             """
             <textarea class="FormControl-textarea FormControl-medium"></textarea>
             <div class="FormControl-caption">Caption</div>
             <div class="FormControl">
             <div class="form-group-header"><label class="FormControl-label"></label><span aria-hidden="true">*</span></div><textarea
             class="FormControl-textarea FormControl-medium"></textarea>
             <div class="FormControl-caption">Caption</div>
             </div>
             <textarea class="FormControl-textarea FormControl-medium"></textarea>
             """
             |> format_html()
  end

  test "Attribute: is_form_control" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.textarea form={:user} name="first_name" is_form_control />
           """)
           |> format_html() ==
             """
             <div class="FormControl">
             <div class="form-group-header"><label class="FormControl-label" for="user_first_name">First name</label><span aria-hidden="true">*</span></div>
             <textarea class="FormControl-textarea FormControl-medium" id="user_first_name" name="user[first_name]"></textarea>
             </div>
             """
             |> format_html()
  end

  test "Attribute: form_control (label)" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.textarea
             form={:user}
             field="first_name"
             form_control={
               %{
                 label: "Some label"
               }
             }
           />
           """)
           |> format_html() ==
             """
             <div class="FormControl">
             <div class="form-group-header"><label class="FormControl-label" for="user_first_name">Some label</label><span aria-hidden="true">*</span></div>
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

  test "Attribute: classes" do
    assigns = %{
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
      class: "my-text-input",
      form: %{@default_form | source: @error_changeset}
    }

    assert rendered_to_string(~H"""
           <.textarea
             classes={@classes}
             form_control={@form_control_attrs}
             class={@class}
             caption={fn -> "Caption" end}
             form={@form}
             field={:first_name}
           />
           """)
           |> format_html() ==
             """
             <div class="FormControl group-x control-x pl-invalid">
             <div class="form-group-header header-x"><label class="FormControl-label label-x" for="user_first_name">First
             name</label><span aria-hidden="true">*</span></div>
             <div class="pl-invalid" phx-feedback-for="user[first_name]"><textarea aria-describedby="user_first_name-validation"
             class="FormControl-textarea FormControl-medium input-x my-text-input" id="user_first_name" invalid=""
             name="user[first_name]"></textarea></div>
             <div class="FormControl-inlineValidation FormControl-inlineValidation--error validation_message-x"
             id="user_first_name-validation" phx-feedback-for="user[first_name]"><svg class="octicon"
             xmlns="http://www.w3.org/2000/svg" width="12" height="12"
             viewBox="0 0 12 12">STRIPPED_SVG_PATHS</svg><span>can&#39;t be blank</span></div>
             <div class="FormControl-caption caption-x">Caption</div>
             </div>
             """
             |> format_html()
  end
end
