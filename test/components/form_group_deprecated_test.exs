defmodule PrimerLive.TestComponents.FormGroupDeprecatedTest do
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

  test "Called without options : should render the component" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.form_group>inputs</.form_group>
           """)
           |> format_html() ==
             """
             <div class="FormControl form-group">inputs</div>
             """
             |> format_html()
  end

  test "Attribute: form and field (atoms)" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.form_group form={:user} field={:first_name}>inputs</.form_group>
           """)
           |> format_html() ==
             """
             <div class="FormControl form-group">
             <div class="form-group-header"><label class="FormControl-label">First name</label></div>inputs
             </div>
             """
             |> format_html()
  end

  test "Attribute: field as string" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.form_group form={:user} field="first_name">inputs</.form_group>
           """)
           |> format_html() ==
             """
             <div class="FormControl form-group">
             <div class="form-group-header"><label class="FormControl-label">First name</label></div>inputs
             </div>
             """
             |> format_html()
  end

  test "Attribute: is_hide_label" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.form_group is_hide_label>inputs</.form_group>
           """)
           |> format_html() ==
             """
             <div class="FormControl form-group">inputs</div>
             """
             |> format_html()
  end

  test "Attribute: is_disabled" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.form_group is_disabled>inputs</.form_group>
           """)
           |> format_html() ==
             """
             <div class="FormControl form-group pl-FormControl-disabled">inputs</div>
             """
             |> format_html()
  end

  test "Extra attributes" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.form_group dir="rtl">inputs</.form_group>
           """)
           |> format_html() ==
             """
             <div class="FormControl form-group" dir="rtl">inputs</div>
             """
             |> format_html()
  end

  test "Classes" do
    assigns = %{
      form: @default_form
    }

    assert rendered_to_string(~H"""
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
             form={@form}
             field={:first_name}
           >
             inputs
           </.form_group>
           """)
           |> format_html() ==
             """
             <div class="FormControl form-group my-form-group group-x control-x pl-neutral">
             <div class="form-group-header header-x"><label class="FormControl-label label-x">First name</label></div>inputs
             </div>
             """
             |> format_html()
  end

  test "Checkboxes" do
    form = %Phoenix.HTML.Form{
      impl: Phoenix.HTML.FormData.Atom,
      id: "user",
      name: "user",
      params: %{"available_for_hire" => ""},
      source: %Ecto.Changeset{
        action: :validate,
        changes: %{},
        errors: [
          available_for_hire: {"can't be blank", [validation: :required]}
        ],
        data: nil,
        valid?: false
      }
    }

    assigns = %{
      form: form
    }

    assert rendered_to_string(~H"""
           <.form_group form={@form} field={:available_for_hire}>
             <.checkbox form={@form} field={:available_for_hire} checked_value="admin" />
             <.checkbox form={@form} field={:available_for_hire} checked_value="editor" />
           </.form_group>
           """)
           |> format_html() ==
             """
             <div class="FormControl form-group pl-invalid">
             <div class="form-group-header"><label class="FormControl-label">Available for hire</label></div><span
             class="FormControl-checkbox-wrap pl-invalid" phx-feedback-for="user[available_for_hire]"><input
             name="user[available_for_hire]" type="hidden" value="false" /><input class="FormControl-checkbox"
             id="user_available_for_hire_admin" invalid="" name="user[available_for_hire]" type="checkbox"
             value="admin" /><span class="FormControl-checkbox-labelWrap"><label class="FormControl-label"
             for="user_available_for_hire_admin">Admin</label></span></span><span
             class="FormControl-checkbox-wrap pl-invalid" phx-feedback-for="user[available_for_hire]"><input
             name="user[available_for_hire]" type="hidden" value="false" /><input class="FormControl-checkbox"
             id="user_available_for_hire_editor" invalid="" name="user[available_for_hire]" type="checkbox"
             value="editor" /><span class="FormControl-checkbox-labelWrap"><label class="FormControl-label"
             for="user_available_for_hire_editor">Editor</label></span></span>
             </div>
             """
             |> format_html()
  end
end
