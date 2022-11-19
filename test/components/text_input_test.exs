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
             <input class="form-control" id="_first_name" name="first_name" type="text" />
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

  test "Attributes: is_contrast, is_full_width, is_hide_webkit_autofill, is_large, is_small, is_short, is_shorter" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.text_input is_contrast />
           <.text_input is_full_width />
           <.text_input is_hide_webkit_autofill />
           <.text_input is_large />
           <.text_input is_small />
           <.text_input is_short />
           <.text_input is_shorter />
           """)
           |> format_html() ==
             """
             <input class="form-control input-contrast" id="_" name="[]" type="text" />
             <input class="form-control input-block" id="_" name="[]" type="text" />
             <input class="form-control input-hide-webkit-autofill" id="_" name="[]" type="text" />
             <input class="form-control input-lg" id="_" name="[]" type="text" />
             <input class="form-control input-sm" id="_" name="[]" type="text" />
             <input class="form-control short" id="_" name="[]" type="text" />
             <input class="form-control shorter" id="_" name="[]" type="text" />
             """
             |> format_html()
  end

  test "Attribute: is_form_group" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.text_input form={:user} name="first_name" is_form_group />
           """)
           |> format_html() ==
             """
             <div class="form-group">
             <div class="form-group-header"><label for="user_first_name">First name</label></div>
             <div class="form-group-body"><input class="form-control" id="user_first_name" name="first_name" type="text" /></div>
             </div>
             """
             |> format_html()
  end

  test "Attribute: form_group (label)" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.text_input
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
             <div class="form-group-body"><input class="form-control" id="user_first_name" name="user[first_name]" type="text" /></div>
             </div>
             """
             |> format_html()
  end

  test "Attribute: form_group (validation_message)" do
    assigns = %{
      form: @default_form
    }

    assert rendered_to_string(~H"""
           <.text_input
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
             <div class="form-group-body"><input aria-describedby="first_name-validation" class="form-control" id="user_first_name" name="user[first_name]" type="text" value="" />
             <div class="FormControl-inlineValidation FormControl-inlineValidation--error" id="first_name-validation">
             <svg class="octicon" xmlns="http://www.w3.org/2000/svg" width="12" height="12" viewBox="0 0 12 12"><path fill-rule="evenodd" d="M4.855.708c.5-.896 1.79-.896 2.29 0l4.675 8.351a1.312 1.312 0 01-1.146 1.954H1.33A1.312 1.312 0 01.183 9.058L4.855.708zM7 7V3H5v4h2zm-1 3a1 1 0 100-2 1 1 0 000 2z"></path></svg>
             <span>Please enter your first name</span></div>
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
             <input class="form-control" id="_first_name" name="first_name" type="text" />
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
             <input aria-label="Enter your first name" class="form-control" id="_first_name" name="first_name" placeholder="Enter your first name" type="text" />
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
             <input aria-label="Enter your first name" class="form-control" id="_first_name" name="first_name" type="text" />
             """
             |> format_html()
  end

  test "Extra attributes: tabindex" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.text_input name="first_name" tabindex="1" />
           """)
           |> format_html() ==
             """
             <input class="form-control" id="_first_name" name="first_name" tabindex="1" type="text" />
             """
             |> format_html()
  end

  test "Attribute: class" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.text_input class="my-input" />
           """)
           |> format_html() ==
             """
             <input class="form-control my-input" id="_" name="[]" type="text" />
             """
             |> format_html()
  end

  test "Slot: group_button" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.text_input>
             <:group_button>
               <.button>Send</.button>
             </:group_button>
           </.text_input>
           <.text_input>
             <:group_button>
               <.button aria-label="Copy">
                 <.octicon name="paste-16" />
               </.button>
             </:group_button>
           </.text_input>
           """)
           |> format_html() ==
             """
             <div class="input-group">
             <input class="form-control" id="_" name="[]" type="text" />
             <span class="input-group-button">
             <button class="btn" type="button">Send</button>
             </span>
             </div>
             <div class="input-group">
             <input class="form-control" id="_" name="[]" type="text" />
             <span class="input-group-button">
             <button class="btn" type="button" aria-label="Copy">
             <svg class="octicon" xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16"><path fill-rule="evenodd" d="M5.75 1a.75.75 0 00-.75.75v3c0 .414.336.75.75.75h4.5a.75.75 0 00.75-.75v-3a.75.75 0 00-.75-.75h-4.5zm.75 3V2.5h3V4h-3zm-2.874-.467a.75.75 0 00-.752-1.298A1.75 1.75 0 002 3.75v9.5c0 .966.784 1.75 1.75 1.75h8.5A1.75 1.75 0 0014 13.25v-9.5a1.75 1.75 0 00-.874-1.515.75.75 0 10-.752 1.298.25.25 0 01.126.217v9.5a.25.25 0 01-.25.25h-8.5a.25.25 0 01-.25-.25v-9.5a.25.25 0 01.126-.217z"></path></svg>
             </button>
             </span>
             </div>
             """
             |> format_html()
  end
end
