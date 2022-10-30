defmodule PrimerLive.TestComponents.TextInputTest do
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

  test "Called without options or inner_block: should render the component" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.text_input />
           """)
           |> format_html() ==
             """
             <input class="form-control" id="_" name="[]" type="text" />
             """
             |> format_html()
  end

  test "Called with invalid form value" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.text_input form="x" />
           """)
           |> format_html() ==
             """
             attr form: invalid value
             """
             |> format_html()
  end

  test "Attribute: is_group" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.text_input form={:user} field={:first_name} is_group />
           """)
           |> format_html() ==
             """
             <div class="form-group">
             <div class="form-group-header">
             <label for="user_first_name">First name</label>
             </div>
             <div class="form-group-body">
             <input class="form-control" id="user_first_name" name="user[first_name]" type="text" />
             </div>
             </div>
             """
             |> format_html()
  end

  test "Attribute: form and field (atoms)" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.text_input form={:user} field={:first_name} />
           """)
           |> format_html() ==
             """
             <input class="form-control" id="user_first_name" name="user[first_name]" type="text" />
             """
             |> format_html()
  end

  test "Attribute: field as string" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.text_input form={:user} field="first_name" />
           """)
           |> format_html() ==
             """
             <input class="form-control" id="user_first_name" name="user[first_name]" type="text" />
             """
             |> format_html()
  end

  test "Attribute: name only" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.text_input name="first_name" />
           """)
           |> format_html() ==
             """
             <input class="form-control" id="_" name="first_name" type="text" />
             """
             |> format_html()
  end

  test "Attribute: types" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.text_input type={:x} />
           <.text_input type="color" />
           <.text_input type="date" />
           <.text_input type="datetime-local" />
           <.text_input type="email" />
           <.text_input type="file" />
           <.text_input type="hidden" />
           <.text_input type="number" />
           <.text_input type="password" />
           <.text_input type="range" />
           <.text_input type="search" />
           <.text_input type="telephone" />
           <.text_input type="text" />
           <.text_input type="textarea" />
           <.text_input type="time" />
           <.text_input type="url" />
           """)
           |> format_html() ==
             """
             <input class="form-control" id="_" name="[]" type="text" />
             <input class="form-control" id="_" name="[]" type="color" />
             <input class="form-control" id="_" name="[]" type="date" />
             <input class="form-control" id="_" name="[]" type="datetime-local" />
             <input class="form-control" id="_" name="[]" type="email" />
             <input class="form-control" id="_" name="[]" type="file" />
             <input class="form-control" id="_" name="[]" type="hidden" />
             <input class="form-control" id="_" name="[]" type="number" />
             <input class="form-control" id="_" name="[]" type="password" />
             <input class="form-control" id="_" name="[]" type="range" />
             <input class="form-control" id="_" name="[]" type="search" />
             <input class="form-control" id="_" name="[]" type="tel" />
             <input class="form-control" id="_" name="[]" type="text" />
             <textarea class="form-control" id="_" name="[]"></textarea>
             <input class="form-control" id="_" name="[]" type="time" />
             <input class="form-control" id="_" name="[]" type="url" />
             """
             |> format_html()
  end

  test "Attributes: is_contrast, is_full_width, is_hide_webkit_autofill, is_large, is_small" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.text_input is_contrast />
           <.text_input is_full_width />
           <.text_input is_hide_webkit_autofill />
           <.text_input is_large />
           <.text_input is_small />
           """)
           |> format_html() ==
             """
             <input class="form-control input-contrast" id="_" name="[]" type="text" />
             <input class="form-control input-block" id="_" name="[]" type="text" />
             <input class="form-control input-hide-webkit-autofill" id="_" name="[]" type="text" />
             <input class="form-control input-lg" id="_" name="[]" type="text" />
             <input class="form-control input-sm" id="_" name="[]" type="text" />
             """
             |> format_html()
  end

  test "Attribute: is_short without group: should render an error message" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.text_input is_short />
           """)
           |> format_html() ==
             """
             attr is_short: must be used in combination with a group slot
             """
             |> format_html()
  end

  test "Attribute: is_short with group slot" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.text_input form={:f} field={:first_name} is_short>
             <:group></:group>
           </.text_input>
           """)
           |> format_html() ==
             """
             <div class="form-group">
             <div class="form-group-header"><label for="f_first_name">First name</label></div>
             <div class="form-group-body"><input class="form-control short" id="f_first_name" name="f[first_name]" type="text" />
             </div>
             </div>
             """
             |> format_html()
  end

  test "Extra attributes" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.text_input name="first_name" />
           """)
           |> format_html() ==
             """
             <input class="form-control" id="_" name="first_name" type="text" />
             """
             |> format_html()
  end

  test "Extra attributes: placeholder (and implicit aria-label)" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.text_input name="first_name" placeholder="Enter your first name" />
           """)
           |> format_html() ==
             """
             <input aria-label="Enter your first name" class="form-control" id="_" name="first_name" placeholder="Enter your first name" type="text" />
             """
             |> format_html()
  end

  test "Extra attributes: explicit aria_label" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.text_input name="first_name" aria_label="Enter your first name" />
           """)
           |> format_html() ==
             """
             <input aria-label="Enter your first name" class="form-control" id="_" name="first_name" type="text" />
             """
             |> format_html()
  end

  test "Attribute: classes" do
    assigns = %{
      form: @default_form
    }

    assert rendered_to_string(~H"""
           <.text_input
             class="my-input"
             classes={
               %{
                 group: "group-x",
                 header: "header-x",
                 body: "body-x",
                 group_label: "group-label-x",
                 input: "input-x",
                 note: "note-x"
               }
             }
             form={@form}
             field={:first_name}
           >
             <:group class="my-group"></:group>
           </.text_input>
           """)
           |> format_html() ==
             """
             <div class="form-group errored my-group group-x">
             <div class="form-group-header header-x"><label class="group-label-x" for="user_first_name">First name</label></div>
             <div class="form-group-body body-x"><input aria-describedby="first_name-validation"
             class="form-control my-input input-x" id="user_first_name" name="user[first_name]" type="text" value="" /></div>
             <p class="note error note-x" id="first_name-validation">can&#39;t be blank</p>
             </div>
             """
             |> format_html()
  end

  test "Group slot with label, without inner_block" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.text_input form={:user} field={:first_name}>
             <:group label="Some label"></:group>
           </.text_input>
           """)
           |> format_html() ==
             """
             <div class="form-group">
             <div class="form-group-header">
             <label for="user_first_name">Some label</label>
             </div>
             <div class="form-group-body">
             <input class="form-control" id="user_first_name" name="user[first_name]" type="text" />
             </div>
             </div>
             """
             |> format_html()
  end

  test "Group slot with label and inner_block" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.text_input form={:user} field={:first_name}>
             <:group :let={field} label="Some label">
               <h2><%= field.label %></h2>
             </:group>
           </.text_input>
           """)
           |> format_html() ==
             """
             <div class="form-group">
             <div class="form-group-header">
             <h2>
             <label for="user_first_name">Some label</label>
             </h2>
             </div>
             <div class="form-group-body"><input class="form-control" id="user_first_name" name="user[first_name]" type="text" />
             </div>
             </div>
             """
             |> format_html()
  end

  test "Group slot with field_state" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.text_input form={:user} field={:first_name}>
             <:group :let={field} label="Some label">
               <h2>
                 <%= if !field.field_state.valid? do %>
                   <div>Please correct your input</div>
                 <% end %>

                 <%= field.label %>
               </h2>
             </:group>
           </.text_input>
           """)
           |> format_html() ==
             """
             <div class="form-group">
             <div class="form-group-header">
             <h2>
             <div>Please correct your input</div>
             <label for="user_first_name">Some label</label>
             </h2>
             </div>
             <div class="form-group-body"><input class="form-control" id="user_first_name" name="user[first_name]" type="text" />
             </div>
             </div>
             """
             |> format_html()
  end

  test "Group slot with attributes label and class" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.text_input form={:f} field={:first_name}>
             <:group label="Some label" class="x"></:group>
           </.text_input>
           """)
           |> format_html() ==
             """
             <div class="form-group x">
             <div class="form-group-header"><label for="f_first_name">Some label</label></div>
             <div class="form-group-body"><input class="form-control" id="f_first_name" name="f[first_name]" type="text" /></div>
             </div>
             """
             |> format_html()
  end

  test "Group slot with extra attribute" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.text_input form={:f} field={:first_name} dir="rtl">
             <:group></:group>
           </.text_input>
           """)
           |> format_html() ==
             """
             <div dir="rtl" class="form-group">
             <div class="form-group-header"><label for="f_first_name">First name</label></div>
             <div class="form-group-body"><input class="form-control" id="f_first_name" name="f[first_name]" type="text" /></div>
             </div>
             """
             |> format_html()
  end

  test "Validation: default error" do
    assigns = %{
      form: @default_form
    }

    assert rendered_to_string(~H"""
           <.text_input form={@form} field={:first_name} is_group />
           """)
           |> format_html() ==
             """
             <div class="form-group errored">
             <div class="form-group-header"><label for="user_first_name">First name</label></div>
             <div class="form-group-body"><input aria-describedby="first_name-validation" class="form-control" id="user_first_name"
                 name="user[first_name]" type="text" value="" /></div>
             <p class="note error" id="first_name-validation">can&#39;t be blank</p>
             </div>
             """
             |> format_html()
  end

  test "Validation: custom error message" do
    assigns = %{
      form: @default_form
    }

    assert rendered_to_string(~H"""
           <.text_input form={@form} field={:first_name}>
             <:group validation_message={
               fn field_state ->
                 if !field_state.valid?, do: "Please enter your first name"
               end
             }>
             </:group>
           </.text_input>
           """)
           |> format_html() ==
             """
             <div class="form-group errored">
             <div class="form-group-header"><label for="user_first_name">First name</label></div>
             <div class="form-group-body"><input aria-describedby="first_name-validation" class="form-control" id="user_first_name"
             name="user[first_name]" type="text" value="" /></div>
             <p class="note error" id="first_name-validation">Please enter your first name</p>
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
           <.text_input form={@update_form} field={:first_name}>
             <:group validation_message={
               fn field_state ->
                 if field_state.valid? && field_state.changeset.action == :validate, do: "Is available"
               end
             }>
             </:group>
           </.text_input>
           """)
           |> format_html() ==
             """
             <div class="form-group">
             <div class="form-group-header"><label for="user_first_name">First name</label></div>
             <div class="form-group-body">
             <input class="form-control" id="user_first_name" name="user[first_name]" type="text" value="anna" />
             </div>
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
           <.text_input form={@validate_form} field={:first_name}>
             <:group validation_message={
               fn field_state ->
                 if field_state.valid? && field_state.changeset.action == :validate, do: "Is available"
               end
             }>
             </:group>
           </.text_input>
           """)
           |> format_html() ==
             """
             <div class="form-group successed">
             <div class="form-group-header"><label for="user_first_name">First name</label></div>
             <div class="form-group-body"><input aria-describedby="first_name-validation" class="form-control" id="user_first_name"
             name="user[first_name]" type="text" value="anna" /></div>
             <p class="note success" id="first_name-validation">Is available</p>
             </div>
             """
             |> format_html()
  end
end
