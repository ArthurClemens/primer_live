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

  test "Attribute: classes" do
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
             <div class="form-group-header header-x">
             <label class="label-x" for="user_first_name">First name</label>
             </div>
             <div class="form-group-body body-x">
             inputs
             <p class="note error validation-message-x" id="first_name-validation">can&#39;t be blank</p>
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
             <div class="form-group-body">inputs<p class="note error" id="first_name-validation">can&#39;t be blank</p>
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
             <div class="form-group-body">inputs<p class="note error" id="first_name-validation">Please enter your first name</p>
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
             <div class="form-group-body">inputs<p class="note success" id="first_name-validation">Is available</p>
             </div>
             </div>
             """
             |> format_html()
  end
end
