defmodule PrimerLive.TestComponents.TextareaTest do
  use ExUnit.Case
  use PrimerLive
  import PrimerLive.Helpers.TestHelpers

  import Phoenix.Component
  import Phoenix.LiveViewTest

  alias PrimerLive.TestHelpers.Repo.Users

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
    changeset = Users.init()

    assigns = %{
      changeset: changeset,
      field: :first_name
    }

    assert rendered_to_string(~H"""
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
           """)
           |> format_html() ==
             """
             <form method="post"><textarea class="FormControl-textarea FormControl-medium" id="user_first_name"
             name="user[first_name]"></textarea>
             <div class="FormControl-caption">Caption 1</div>
             </form>
             <form method="post">
             <div class="FormControl pl-invalid">
             <div class="form-group-header"><label class="FormControl-label" for="user_first_name">First name</label><span
                aria-hidden="true">*</span></div><textarea class="FormControl-textarea FormControl-medium"
             id="user_first_name" name="user[first_name]"></textarea>
             <div class="FormControl-caption">Caption 2</div>
             </div>
             </form>
             <form method="post"><textarea class="FormControl-textarea FormControl-medium" id="user_first_name"
             name="user[first_name]"></textarea></form>
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
             <div class="form-group-header"><label class="FormControl-label" for="user_first_name">First name</label></div>
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
             <div class="form-group-header"><label class="FormControl-label" for="user_first_name">Some label</label></div>
             <textarea class="FormControl-textarea FormControl-medium" id="user_first_name" name="user[first_name]"></textarea>
             </div>
             """
             |> format_html()
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

    assert rendered_to_string(~H"""
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
           """)
           |> format_html() ==
             """
             <form method="post">
             <div class="pl-invalid" phx-feedback-for="user[first_name]"><textarea aria-describedby="user_first_name-validation"
             class="FormControl-textarea FormControl-medium" id="user_first_name" invalid="" name="user[first_name]"></textarea>
             </div>
             <div class="FormControl-inlineValidation FormControl-inlineValidation--error" id="user_first_name-validation"
             phx-feedback-for="user[first_name]"><svg class="octicon" xmlns="http://www.w3.org/2000/svg" width="12" height="12"
             viewBox="0 0 12 12">STRIPPED_SVG_PATHS</svg><span>Please enter your first name</span></div>
             </form>
             """
             |> format_html()
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

    assert rendered_to_string(~H"""
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
           """)
           |> format_html() ==
             """
             <form method="post">
             <div class="FormControl group-x control-x pl-invalid">
             <div class="form-group-header header-x"><label class="FormControl-label label-x" for="user_first_name">First
                name</label><span aria-hidden="true">*</span></div><textarea
             class="FormControl-textarea FormControl-medium input-x my-text-input" id="user_first_name"
             name="user[first_name]"></textarea>
             <div class="FormControl-caption caption-x">Caption</div>
             </div>
             </form>
             """
             |> format_html()
  end
end
