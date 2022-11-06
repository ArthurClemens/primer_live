defmodule PrimerLive.TestComponents.FormGroupTest do
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

  @default_changeset %Ecto.Changeset{
    action: nil,
    changes: %{},
    errors: [],
    data: nil,
    valid?: true
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
             <div class="form-group-header"><label for="user_first_name">First name</label></div>
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
             <label for="user_first_name">First name</label>
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
                 label: "label-x",
                 validation_message: "validation-message-x"
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
             <div class="form-group errored my-form-group group-x">
             <div class="form-group-header header-x"><label class="label-x" for="user_first_name">First name</label></div>
             <div class="form-group-body body-x">inputs<div class="FormControl-inlineValidation FormControl-inlineValidation--error validation-message-x" id="first_name-validation"><svg class="octicon" xmlns="http://www.w3.org/2000/svg" width="12" height="12" viewBox="0 0 12 12">
             <path fill-rule="evenodd" d="M4.855.708c.5-.896 1.79-.896 2.29 0l4.675 8.351a1.312 1.312 0 01-1.146 1.954H1.33A1.312 1.312 0 01.183 9.058L4.855.708zM7 7V3H5v4h2zm-1 3a1 1 0 100-2 1 1 0 000 2z"></path>
             </svg><span>can&#39;t be blank</span></div>
             </div>
             </div>
             """
             |> format_html()
  end

  test "Validation: default error" do
    assigns = %{
      form: @default_form
    }

    assert rendered_to_string(~H"""
           <.form_group form={@form} field={:first_name}>inputs</.form_group>
           """)
           |> format_html() ==
             """
             <div class="form-group errored">
             <div class="form-group-header"><label for="user_first_name">First name</label></div>
             <div class="form-group-body">inputs<div class="FormControl-inlineValidation FormControl-inlineValidation--error" id="first_name-validation"><svg class="octicon" xmlns="http://www.w3.org/2000/svg" width="12" height="12" viewBox="0 0 12 12">
             <path fill-rule="evenodd" d="M4.855.708c.5-.896 1.79-.896 2.29 0l4.675 8.351a1.312 1.312 0 01-1.146 1.954H1.33A1.312 1.312 0 01.183 9.058L4.855.708zM7 7V3H5v4h2zm-1 3a1 1 0 100-2 1 1 0 000 2z"></path>
             </svg><span>can&#39;t be blank</span></div>
             </div>
             </div>
             """
             |> format_html()
  end

  test "Validation: custom error message" do
    assigns = %{
      form: @default_form
    }

    assert rendered_to_string(~H"""
           <.form_group
             form={@form}
             field={:first_name}
             validation_message={
               fn field_state ->
                 if !field_state.valid?, do: "Please enter your first name"
               end
             }
           >
             inputs
           </.form_group>
           """)
           |> format_html() ==
             """
             <div class="form-group errored">
             <div class="form-group-header"><label for="user_first_name">First name</label></div>
             <div class="form-group-body">inputs<div class="FormControl-inlineValidation FormControl-inlineValidation--error" id="first_name-validation"><svg class="octicon" xmlns="http://www.w3.org/2000/svg" width="12" height="12" viewBox="0 0 12 12">
             <path fill-rule="evenodd" d="M4.855.708c.5-.896 1.79-.896 2.29 0l4.675 8.351a1.312 1.312 0 01-1.146 1.954H1.33A1.312 1.312 0 01.183 9.058L4.855.708zM7 7V3H5v4h2zm-1 3a1 1 0 100-2 1 1 0 000 2z"></path>
             </svg><span>Please enter your first name</span></div>
             </div>
             </div>
             """
             |> format_html()
  end

  test "Validation: custom success message (action: :update)" do
    update_changeset = %{@default_changeset | action: :update}

    assigns = %{
      update_form: %{@default_form | source: update_changeset, params: %{"first_name" => "anna"}}
    }

    assert rendered_to_string(~H"""
           <.form_group
             form={@update_form}
             field={:first_name}
             validation_message={
               fn field_state ->
                 if field_state.valid? && field_state.changeset.action == :validate, do: "Is available"
               end
             }
           >
             inputs
           </.form_group>
           """)
           |> format_html() ==
             """
             <div class="form-group">
             <div class="form-group-header"><label for="user_first_name">First name</label></div>
             <div class="form-group-body">inputs</div>
             </div>
             """
             |> format_html()
  end

  test "Validation: custom success message (action: :validate)" do
    validate_changeset = %{@default_changeset | action: :validate}

    assigns = %{
      validate_form: %{
        @default_form
        | source: validate_changeset,
          params: %{"first_name" => "anna"}
      }
    }

    assert rendered_to_string(~H"""
           <.form_group
             form={@validate_form}
             field={:first_name}
             validation_message={
               fn field_state ->
                 if field_state.valid? && field_state.changeset.action == :validate, do: "Is available"
               end
             }
           >
             inputs
           </.form_group>
           """)
           |> format_html() ==
             """
             <div class="form-group successed">
             <div class="form-group-header"><label for="user_first_name">First name</label></div>
             <div class="form-group-body">inputs<div class="FormControl-inlineValidation FormControl-inlineValidation--success" id="first_name-validation"><svg class="octicon" xmlns="http://www.w3.org/2000/svg" width="12" height="12" viewBox="0 0 12 12">
             <path fill-rule="evenodd" d="M6 0a6 6 0 100 12A6 6 0 006 0zm-.705 8.737L9.63 4.403 8.392 3.166 5.295 6.263l-1.7-1.702L2.356 5.8l2.938 2.938z"></path>
             </svg><span>Is available</span></div>
             </div>
             </div>
             """
             |> format_html()
  end
end
