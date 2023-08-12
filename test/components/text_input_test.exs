defmodule PrimerLive.TestComponents.TextInputTest do
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

  test "Called without options or inner_block: should render the component" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.text_input />
           """)
           |> format_html() ==
             """
             <input class="FormControl-input FormControl-medium" type="text" />
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
             <input class="FormControl-input FormControl-medium" id="user_first_name" name="user[first_name]" type="text" />
             """
             |> format_html()
  end

  test "Attribute: name, value" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.text_input name="first_name" value="Greta" />
           """)
           |> format_html() ==
             """
             <input class="FormControl-input FormControl-medium" id="first_name" name="first_name" type="text" value="Greta" />
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
             <input class="FormControl-input FormControl-medium" id="user_first_name" name="user[first_name]" type="text" />
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
             <input class="FormControl-input FormControl-medium" id="first_name" name="first_name" type="text" />
             """
             |> format_html()
  end

  test "Attribute: size" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.text_input size="3" />
           <.text_input size={3} />
           """)
           |> format_html() ==
             """
             <input class="FormControl-input FormControl-medium" size="3" type="text" />
             <input class="FormControl-input FormControl-medium" size="3" type="text" />
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
             <input class="FormControl-input FormControl-medium" type="text" />
             <input class="FormControl-input FormControl-medium" type="color" />
             <input class="FormControl-input FormControl-medium" type="date" />
             <input class="FormControl-input FormControl-medium" type="datetime-local" />
             <input class="FormControl-input FormControl-medium" type="email" />
             <input class="FormControl-input FormControl-medium" type="file" />
             <input class="FormControl-input FormControl-medium" type="hidden" />
             <input class="FormControl-input FormControl-medium" type="number" />
             <input class="FormControl-input FormControl-medium" type="password" />
             <input class="FormControl-input FormControl-medium" type="range" />
             <input class="FormControl-input FormControl-medium" type="search" />
             <input class="FormControl-input FormControl-medium" type="tel" />
             <input class="FormControl-input FormControl-medium" type="text" />
             <textarea class="FormControl-textarea FormControl-medium"></textarea>
             <input class="FormControl-input FormControl-medium" type="time" />
             <input class="FormControl-input FormControl-medium" type="url" />
             """
             |> format_html()
  end

  test "Attributes: is_monospace, is_contrast, is_full_width, is_hide_webkit_autofill, is_large, is_small, is_short, is_shorter" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.text_input is_monospace />
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
             <input class="FormControl-input FormControl-medium FormControl-monospace" type="text" />
             <input class="FormControl-input FormControl-inset FormControl-medium" type="text" />
             <input class="FormControl-input FormControl-medium FormControl--fullWidth" type="text" />
             <input class="FormControl-input input-hide-webkit-autofill FormControl-medium" type="text" />
             <input class="FormControl-input FormControl-large" type="text" />
             <input class="FormControl-input FormControl-small" type="text" />
             <input class="FormControl-input FormControl-medium FormControl--short" type="text" />
             <input class="FormControl-input FormControl-medium FormControl--shorter" type="text" />
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
             <div class="form-group-body"><input class="FormControl-input FormControl-medium" id="user_first_name" name="user[first_name]" type="text" /></div>
             </div>
             """
             |> format_html()
  end

  test "Attribute: is_form_group with input_id" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.text_input form={:user} name="first_name" is_form_group input_id="xyz" />
           """)
           |> format_html() ==
             """
             <div class="form-group">
             <div class="form-group-header"><label for="xyz">First name</label></div>
             <div class="form-group-body"><input class="FormControl-input FormControl-medium" id="xyz" name="user[first_name]" type="text" /></div>
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
             <div class="form-group-body"><input class="FormControl-input FormControl-medium" id="user_first_name" name="user[first_name]" type="text" /></div>
             </div>
             """
             |> format_html()
  end

  test "Default validation message" do
    assigns = %{
      form: %{@default_form | source: @error_changeset}
    }

    assert rendered_to_string(~H"""
           <.text_input form={@form} field={:first_name} />
           """)
           |> format_html() ==
             """
             <div class="pl-invalid" phx-feedback-for="user[first_name]"><input aria-describedby="user_first_name-validation"
             class="FormControl-input FormControl-medium" id="user_first_name" invalid="" name="user[first_name]" type="text"
             value="" /></div>
             <div class="FormControl-inlineValidation FormControl-inlineValidation--error" id="user_first_name-validation"
             phx-feedback-for="user[first_name]"><svg class="octicon" xmlns="http://www.w3.org/2000/svg" width="12" height="12"
             viewBox="0 0 12 12">STRIPPED_SVG_PATHS</svg><span>can&#39;t be blank</span></div>
             """
             |> format_html()
  end

  test "Attribute: validation_message (custom error message)" do
    assigns = %{
      form: %{@default_form | source: @error_changeset}
    }

    assert rendered_to_string(~H"""
           <.text_input
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
             <div class="pl-invalid" phx-feedback-for="user[first_name]"><input aria-describedby="user_first_name-validation"
             class="FormControl-input FormControl-medium" id="user_first_name" invalid="" name="user[first_name]" type="text"
             value="" /></div>
             <div class="FormControl-inlineValidation FormControl-inlineValidation--error" id="user_first_name-validation"
             phx-feedback-for="user[first_name]"><svg class="octicon" xmlns="http://www.w3.org/2000/svg" width="12" height="12"
             viewBox="0 0 12 12">STRIPPED_SVG_PATHS</svg><span>Please enter your first name</span></div>
             """
             |> format_html()
  end

  test "Attribute: validation_message (custom success message)" do
    assigns = %{
      form: %{
        @default_form
        | source: @default_form.source,
          params: %{"first_name" => "anna"}
      }
    }

    assert rendered_to_string(~H"""
           <.text_input
             form={@form}
             field={:first_name}
             validation_message={
               fn field_state ->
                 if field_state.valid?, do: "Available!"
               end
             }
           />
           """)
           |> format_html() ==
             """
             <div class="pl-valid" phx-feedback-for="user[first_name]"><input aria-describedby="user_first_name-validation"
             class="FormControl-input FormControl-medium" id="user_first_name" invalid="" name="user[first_name]" type="text"
             value="anna" /></div>
             <div class="FormControl-inlineValidation FormControl-inlineValidation--success" id="user_first_name-validation"
             phx-feedback-for="user[first_name]"><svg class="octicon" xmlns="http://www.w3.org/2000/svg" width="12" height="12"
             viewBox="0 0 12 12">STRIPPED_SVG_PATHS</svg><span>Available!</span></div>
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
             <input class="FormControl-input FormControl-medium" id="first_name" name="first_name" type="text" />
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
             <input aria-label="Enter your first name" class="FormControl-input FormControl-medium" id="first_name" name="first_name" placeholder="Enter your first name" type="text" />
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
             <input aria-label="Enter your first name" class="FormControl-input FormControl-medium" id="first_name" name="first_name" type="text" />
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
             <input class="FormControl-input FormControl-medium" id="first_name" name="first_name" tabindex="1" type="text" />
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
             <input class="FormControl-input FormControl-medium my-input" type="text" />
             """
             |> format_html()
  end

  test "Attribute: style" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.text_input style="border: 1px solid red;" />
           """)
           |> format_html() ==
             """
             <input class="FormControl-input FormControl-medium" style="border: 1px solid red;" type="text" />
             """
             |> format_html()
  end

  test "Slot: leading_visual" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.text_input>
             <:leading_visual>
               <.octicon name="mail-16" />
             </:leading_visual>
           </.text_input>
           """)
           |> format_html() ==
             """
             <div class="FormControl-input-wrap FormControl-input-wrap--leadingVisual">
             <span class="FormControl-input-leadingVisualWrap">
             <svg class="octicon" xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16">STRIPPED_SVG_PATHS</svg>
             </span>
             <input class="FormControl-input FormControl-medium" type="text" />
             </div>
             """
             |> format_html()
  end

  test "Slot: trailing_action" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.text_input>
             <:trailing_action>
               <.button is_icon_only aria-label="Clear">
                 <.octicon name="x-16" />
               </.button>
             </:trailing_action>
           </.text_input>
           """)
           |> format_html() ==
             """
             <div class="FormControl-input-wrap FormControl-input-wrap--trailingAction">
             <input class="FormControl-input FormControl-medium" type="text" />
             <span class="FormControl-input-trailingAction">
             <button aria-label="Clear" class="btn-octicon" type="button"><svg class="octicon" xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16">STRIPPED_SVG_PATHS</svg>
             </button>
             </span>
             </div>
             """
             |> format_html()
  end

  test "Slot: trailing_action, attr is_divider" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.text_input>
             <:trailing_action is_divider>
               <.button is_icon_only aria-label="Clear">
                 <.octicon name="x-16" />
               </.button>
             </:trailing_action>
           </.text_input>
           """)
           |> format_html() ==
             """
             <div class="FormControl-input-wrap FormControl-input-wrap--trailingAction">
             <input class="FormControl-input FormControl-medium" type="text" />
             <span class="FormControl-input-trailingAction FormControl-input-trailingAction--divider">
             <button aria-label="Clear" class="btn-octicon" type="button">
             <svg class="octicon" xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16">STRIPPED_SVG_PATHS</svg>
             </button>
             </span>
             </div>
             """
             |> format_html()
  end

  test "Slot: trailing_action, attr is_visible_with_value" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.text_input>
             <:trailing_action is_visible_with_value>
               <.button is_icon_only aria-label="Clear">
                 <.octicon name="x-16" />
               </.button>
             </:trailing_action>
           </.text_input>
           """)
           |> format_html() ==
             """
             <div class="FormControl-input-wrap FormControl-input-wrap--trailingAction">
             <input class="FormControl-input FormControl-medium" placeholder=" " type="text" />
             <span class="FormControl-input-trailingAction pl-trailingAction--if-value">
             <button aria-label="Clear" class="btn-octicon" type="button">
             <svg class="octicon" xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16">STRIPPED_SVG_PATHS</svg>
             </button>
             </span>
             </div>
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
             <input class="FormControl-input FormControl-medium" type="text" />
             <span class="input-group-button">
             <button class="btn" type="button">Send</button>
             </span>
             </div>
             <div class="input-group">
             <input class="FormControl-input FormControl-medium" type="text" />
             <span class="input-group-button">
             <button aria-label="Copy" class="btn" type="button">
             <svg class="octicon" xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16"><path fill-rule="evenodd" d="M5.75 1a.75.75 0 00-.75.75v3c0 .414.336.75.75.75h4.5a.75.75 0 00.75-.75v-3a.75.75 0 00-.75-.75h-4.5zm.75 3V2.5h3V4h-3zm-2.874-.467a.75.75 0 00-.752-1.298A1.75 1.75 0 002 3.75v9.5c0 .966.784 1.75 1.75 1.75h8.5A1.75 1.75 0 0014 13.25v-9.5a1.75 1.75 0 00-.874-1.515.75.75 0 10-.752 1.298.25.25 0 01.126.217v9.5a.25.25 0 01-.25.25h-8.5a.25.25 0 01-.25-.25v-9.5a.25.25 0 01.126-.217z"></path></svg>
             </button>
             </span>
             </div>
             """
             |> format_html()
  end

  test "Slot: leading_visual, trailing_action" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.text_input>
             <:leading_visual>
               <.octicon name="person-16" />
             </:leading_visual>
           </.text_input>
           <.text_input>
             <:trailing_action>
               <.button is_close_button aria-label="Clear">
                 <.octicon name="x-16" />
               </.button>
             </:trailing_action>
           </.text_input>
           """)
           |> format_html() ==
             """
             <div class="FormControl-input-wrap FormControl-input-wrap--leadingVisual">
             <span class="FormControl-input-leadingVisualWrap">
             <svg class="octicon" xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16">STRIPPED_SVG_PATHS</svg>
             </span>
             <input class="FormControl-input FormControl-medium" type="text" />
             </div>
             <div class="FormControl-input-wrap FormControl-input-wrap--trailingAction"
             ><input class="FormControl-input FormControl-medium" type="text" />
             <span class="FormControl-input-trailingAction">
             <button aria-label="Clear" class="close-button"
             type="button">
             <svg class="octicon" xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16">STRIPPED_SVG_PATHS</svg>
             </button>
             </span>
             </div>
             """
             |> format_html()
  end
end
