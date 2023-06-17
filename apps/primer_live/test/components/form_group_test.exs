defmodule PrimerLive.TestComponents.FormGroupTest do
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
             <div class="form-group">
             <div class="form-group-body">inputs</div>
             </div>
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
             <div class="form-group">
             <div class="form-group-header"><label>First name</label></div>
             <div class="form-group-body">inputs</div>
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
             <div class="form-group">
             <div class="form-group-header">
             <label>First name</label>
             </div>
             <div class="form-group-body">inputs</div>
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
             <div class="form-group"><div class="form-group-body">inputs</div></div>
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
             <div dir="rtl" class="form-group"><div class="form-group-body">inputs</div></div>
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
                 group: "group-x",
                 header: "header-x",
                 body: "body-x",
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
             <div class="form-group my-form-group group-x">
             <div class="form-group-header header-x"><label class="label-x">First name</label></div>
             <div class="form-group-body body-x">inputs</div>
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
             <div class="form-group">
             <div class="form-group-header">
             <label>Available for hire</label>
             </div>
             <div class="form-group-body">
             <span phx-feedback-for="user[available_for_hire]" class="FormControl-checkbox-wrap pl-invalid">
             <input name="user[available_for_hire]" type="hidden" value="false" />
             <input class="FormControl-checkbox" id="user[available_for_hire][admin]" invalid=""
             name="user[available_for_hire]" type="checkbox" value="admin" />
             <span class="FormControl-checkbox-labelWrap">
             <label class="FormControl-label" for="user[available_for_hire][admin]">Admin</label>
             </span>
             </span>
             <span phx-feedback-for="user[available_for_hire]" class="FormControl-checkbox-wrap pl-invalid">
             <input name="user[available_for_hire]" type="hidden" value="false" />
             <input class="FormControl-checkbox" id="user[available_for_hire][editor]" invalid=""
             name="user[available_for_hire]" type="checkbox" value="editor" />
             <span class="FormControl-checkbox-labelWrap">
             <label class="FormControl-label" for="user[available_for_hire][editor]">Editor</label>
             </span>
             </span>
             </div>
             </div>
             """
             |> format_html()
  end
end
