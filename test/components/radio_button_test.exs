defmodule PrimerLive.TestComponents.RadioButtonTest do
  use ExUnit.Case
  use PrimerLive
  import PrimerLive.Helpers.TestHelpers

  import Phoenix.Component
  import Phoenix.LiveViewTest

  @default_form %Phoenix.HTML.Form{
    id: "user",
    name: "user",
    params: %{"role" => ""},
    source: %Ecto.Changeset{
      action: :validate,
      changes: %{},
      errors: [],
      data: nil,
      valid?: true
    }
  }
  test "Called without options or inner_block: should render the component" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.radio_button />
           """)
           |> format_html() ==
             """
             <div class="FormControl-radio-wrap"><input checked class="FormControl-radio" id="_" name="[]" type="radio" value="" /></div>
             """
             |> format_html()
  end

  test "Called with invalid form value" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.radio_button form="x" />
           """)
           |> format_html() ==
             """
             attr form: invalid value
             """
             |> format_html()
  end

  test "Extra attributes: value" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.radio_button name="role" value="admin" />
           <.radio_button name="role" value="editor" />
           """)
           |> format_html() ==
             """
             <div class="FormControl-radio-wrap"><input class="FormControl-radio" id="_role_admin" name="role" type="radio" value="admin" />
             <div class="FormControl-radio-labelWrap"><label class="FormControl-label" for="_role_admin">Admin</label></div>
             </div>
             <div class="FormControl-radio-wrap"><input class="FormControl-radio" id="_role_editor" name="role" type="radio" value="editor" />
             <div class="FormControl-radio-labelWrap"><label class="FormControl-label" for="_role_editor">Editor</label></div>
             </div>
             """
             |> format_html()
  end

  test "Attribute: form, field and value" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.radio_button form={:user} field={:role} value="admin" />
           <.radio_button form={:user} field={:role} value="editor" />
           """)
           |> format_html() ==
             """
             <div class="FormControl-radio-wrap"><input class="FormControl-radio" id="user_role_admin" name="user[role]" type="radio" value="admin" />
             <div class="FormControl-radio-labelWrap"><label class="FormControl-label" for="user_role_admin">Admin</label></div>
             </div>
             <div class="FormControl-radio-wrap"><input class="FormControl-radio" id="user_role_editor" name="user[role]" type="radio" value="editor" />
             <div class="FormControl-radio-labelWrap"><label class="FormControl-label" for="user_role_editor">Editor</label></div>
             </div>
             """
             |> format_html()
  end

  test "Attribute: field as string" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.radio_button form={:user} field="role" value="admin" />
           <.radio_button form={:user} field="role" value="editor" />
           """)
           |> format_html() ==
             """
             <div class="FormControl-radio-wrap"><input class="FormControl-radio" id="user_role_admin" name="user[role]" type="radio" value="admin" />
             <div class="FormControl-radio-labelWrap"><label class="FormControl-label" for="user_role_admin">Admin</label></div>
             </div>
             <div class="FormControl-radio-wrap"><input class="FormControl-radio" id="user_role_editor" name="user[role]" type="radio" value="editor" />
             <div class="FormControl-radio-labelWrap"><label class="FormControl-label" for="user_role_editor">Editor</label></div>
             </div>
             """
             |> format_html()
  end

  test "Attribute: name only" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.radio_button name="role" value="admin" />
           <.radio_button name="role" value="editor" />
           """)
           |> format_html() ==
             """
             <div class="FormControl-radio-wrap"><input class="FormControl-radio" id="_role_admin" name="role" type="radio" value="admin" />
             <div class="FormControl-radio-labelWrap"><label class="FormControl-label" for="_role_admin">Admin</label></div>
             </div>
             <div class="FormControl-radio-wrap"><input class="FormControl-radio" id="_role_editor" name="role" type="radio" value="editor" />
             <div class="FormControl-radio-labelWrap"><label class="FormControl-label" for="_role_editor">Editor</label></div>
             </div>
             """
             |> format_html()
  end

  test "Attribute: types" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.radio_button name="types" value="x" type={:x} />
           <.radio_button name="types" value="color" type="color" />
           <.radio_button name="types" value="date" type="date" />
           <.radio_button name="types" value="datetime-local" type="datetime-local" />
           <.radio_button name="types" value="email" type="email" />
           <.radio_button name="types" value="file" type="file" />
           <.radio_button name="types" value="hidden" type="hidden" />
           <.radio_button name="types" value="number" type="number" />
           <.radio_button name="types" value="password" type="password" />
           <.radio_button name="types" value="range" type="range" />
           <.radio_button name="types" value="search" type="search" />
           <.radio_button name="types" value="telephone" type="telephone" />
           <.radio_button name="types" value="text" type="text" />
           <.radio_button name="types" value="textarea" type="textarea" />
           <.radio_button name="types" value="time" type="time" />
           <.radio_button name="types" value="url" type="url" />
           """)
           |> format_html() ==
             """
             <div class="FormControl-radio-wrap"><input class="FormControl-radio" id="_types_x" name="types" type="radio" value="x" />
             <div class="FormControl-radio-labelWrap"><label class="FormControl-label" for="_types_x">X</label></div>
             </div>
             <div class="FormControl-radio-wrap"><input class="FormControl-radio" id="_types_color" name="types" type="radio" value="color" />
             <div class="FormControl-radio-labelWrap"><label class="FormControl-label" for="_types_color">Color</label></div>
             </div>
             <div class="FormControl-radio-wrap"><input class="FormControl-radio" id="_types_date" name="types" type="radio" value="date" />
             <div class="FormControl-radio-labelWrap"><label class="FormControl-label" for="_types_date">Date</label></div>
             </div>
             <div class="FormControl-radio-wrap"><input class="FormControl-radio" id="_types_datetime_local" name="types" type="radio" value="datetime-local" />
             <div class="FormControl-radio-labelWrap"><label class="FormControl-label" for="_types_datetime_local">Datetime-local</label></div>
             </div>
             <div class="FormControl-radio-wrap"><input class="FormControl-radio" id="_types_email" name="types" type="radio" value="email" />
             <div class="FormControl-radio-labelWrap"><label class="FormControl-label" for="_types_email">Email</label></div>
             </div>
             <div class="FormControl-radio-wrap"><input class="FormControl-radio" id="_types_file" name="types" type="radio" value="file" />
             <div class="FormControl-radio-labelWrap"><label class="FormControl-label" for="_types_file">File</label></div>
             </div>
             <div class="FormControl-radio-wrap"><input class="FormControl-radio" id="_types_hidden" name="types" type="radio" value="hidden" />
             <div class="FormControl-radio-labelWrap"><label class="FormControl-label" for="_types_hidden">Hidden</label></div>
             </div>
             <div class="FormControl-radio-wrap"><input class="FormControl-radio" id="_types_number" name="types" type="radio" value="number" />
             <div class="FormControl-radio-labelWrap"><label class="FormControl-label" for="_types_number">Number</label></div>
             </div>
             <div class="FormControl-radio-wrap"><input class="FormControl-radio" id="_types_password" name="types" type="radio" value="password" />
             <div class="FormControl-radio-labelWrap"><label class="FormControl-label" for="_types_password">Password</label></div>
             </div>
             <div class="FormControl-radio-wrap"><input class="FormControl-radio" id="_types_range" name="types" type="radio" value="range" />
             <div class="FormControl-radio-labelWrap"><label class="FormControl-label" for="_types_range">Range</label></div>
             </div>
             <div class="FormControl-radio-wrap"><input class="FormControl-radio" id="_types_search" name="types" type="radio" value="search" />
             <div class="FormControl-radio-labelWrap"><label class="FormControl-label" for="_types_search">Search</label></div>
             </div>
             <div class="FormControl-radio-wrap"><input class="FormControl-radio" id="_types_telephone" name="types" type="radio" value="telephone" />
             <div class="FormControl-radio-labelWrap"><label class="FormControl-label" for="_types_telephone">Telephone</label></div>
             </div>
             <div class="FormControl-radio-wrap"><input class="FormControl-radio" id="_types_text" name="types" type="radio" value="text" />
             <div class="FormControl-radio-labelWrap"><label class="FormControl-label" for="_types_text">Text</label></div>
             </div>
             <div class="FormControl-radio-wrap"><input class="FormControl-radio" id="_types_textarea" name="types" type="radio" value="textarea" />
             <div class="FormControl-radio-labelWrap"><label class="FormControl-label" for="_types_textarea">Textarea</label></div>
             </div>
             <div class="FormControl-radio-wrap"><input class="FormControl-radio" id="_types_time" name="types" type="radio" value="time" />
             <div class="FormControl-radio-labelWrap"><label class="FormControl-label" for="_types_time">Time</label></div>
             </div>
             <div class="FormControl-radio-wrap"><input class="FormControl-radio" id="_types_url" name="types" type="radio" value="url" />
             <div class="FormControl-radio-labelWrap"><label class="FormControl-label" for="_types_url">Url</label></div>
             </div>
             """
             |> format_html()
  end

  test "Attribute: checked" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.radio_button name="role" value="admin" />
           <.radio_button name="role" value="editor" checked />
           """)
           |> format_html() ==
             """
             <div class="FormControl-radio-wrap"><input class="FormControl-radio" id="_role_admin" name="role" type="radio" value="admin" />
             <div class="FormControl-radio-labelWrap"><label class="FormControl-label" for="_role_admin">Admin</label></div>
             </div>
             <div class="FormControl-radio-wrap"><input checked class="FormControl-radio" id="_role_editor" name="role" type="radio" value="editor" />
             <div class="FormControl-radio-labelWrap"><label class="FormControl-label" for="_role_editor">Editor</label></div>
             </div>
             """
             |> format_html()
  end

  test "Attribute: classes" do
    assigns = %{
      form: @default_form
    }

    assert rendered_to_string(~H"""
           <.radio_button
             class="my-radio-button"
             classes={
               %{
                 label: "label-x",
                 input: "input-x",
                 hint: "hint-x",
                 disclosure: "disclosure-x"
               }
             }
             form={@form}
             field={:role}
           >
             <:label class="my-label">Some label</:label>
             <:hint class="my-hint">Some hint</:hint>
             <:disclosure class="my-disclosure">Some hint</:disclosure>
           </.radio_button>
           """)
           |> format_html() ==
             """
             <div class="FormControl-radio-wrap my-radio-button"><span phx-feedback-for="user_role_" class="pl-valid"></span><input class="form-checkbox-details-trigger FormControl-radio input-x" id="user_role_" name="user[role]" type="radio" value="" />
             <div class="FormControl-radio-labelWrap"><label class="FormControl-label label-x my-label" aria-live="polite" for="user_role_">Some label</label>
             <p class="FormControl-caption hint-x my-hint">Some hint</p><span class="form-checkbox-details text-normal disclosure-x my-disclosure">Some hint</span>
             </div>
             </div>
             """
             |> format_html()
  end

  test "Extra attributes: tabindex" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.radio_button name="role" tabindex="1" />
           """)
           |> format_html() ==
             """
             <div class="FormControl-radio-wrap"><input checked class="FormControl-radio" id="_role_" name="role" tabindex="1" type="radio" value="" /></div>
             """
             |> format_html()
  end

  test "Label slot" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.radio_button name="role">
             <:label dir="rtl">Some label</:label>
           </.radio_button>
           """)
           |> format_html() ==
             """
             <div class="FormControl-radio-wrap"><input checked class="FormControl-radio" id="_role_" name="role" type="radio" value="" />
             <div class="FormControl-radio-labelWrap"><label dir="rtl" class="FormControl-label" for="_role_">Some label</label></div>
             </div>
             """
             |> format_html()
  end

  test "Label slot with attribute is_emphasised_label" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.radio_button name="role" is_emphasised_label>
             <:label>Some label</:label>
           </.radio_button>
           """)
           |> format_html() ==
             """
             <div class="FormControl-radio-wrap"><input checked class="FormControl-radio" id="_role_" name="role" type="radio" value="" />
             <div class="FormControl-radio-labelWrap"><label class="FormControl-label" for="_role_"><em class="highlight">Some label</em></label></div>
             </div>
             """
             |> format_html()
  end

  test "Disclosure slot" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.radio_button name="role">
             <:label>Some label</:label>
             <:disclosure>
               <span>disclosure content</span>
             </:disclosure>
           </.radio_button>
           """)
           |> format_html() ==
             """
             <div class="FormControl-radio-wrap"><input checked class="form-checkbox-details-trigger FormControl-radio" id="_role_" name="role" type="radio" value="" />
             <div class="FormControl-radio-labelWrap"><label class="FormControl-label" aria-live="polite" for="_role_">Some label</label><span class="form-checkbox-details text-normal"><span>disclosure content</span></span></div>
             </div>
             """
             |> format_html()
  end

  test "Hint slot" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.radio_button name="role">
             <:label>
               Some label
             </:label>
             <:hint>
               Add your <strong>resume</strong> below
             </:hint>
           </.radio_button>
           """)
           |> format_html() ==
             """
             <div class="FormControl-radio-wrap"><input checked class="FormControl-radio" id="_role_" name="role" type="radio" value="" />
             <div class="FormControl-radio-labelWrap"><label class="FormControl-label" for="_role_">Some label</label>
             <p class="FormControl-caption">Add your<strong>resume</strong>below</p>
             </div>
             </div>
             """
             |> format_html()
  end

  test "Hint slot without label (not shown)" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.radio_button name="role">
             <:hint>
               Add your <strong>resume</strong> below
             </:hint>
           </.radio_button>
           """)
           |> format_html() ==
             """
             <div class="FormControl-radio-wrap"><input checked class="FormControl-radio" id="_role_" name="role" type="radio" value="" /></div>
             """
             |> format_html()
  end
end
