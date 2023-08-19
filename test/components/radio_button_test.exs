defmodule PrimerLive.TestComponents.RadioButtonTest do
  use ExUnit.Case
  use PrimerLive
  import PrimerLive.Helpers.TestHelpers

  import Phoenix.Component
  import Phoenix.LiveViewTest

  @default_form %Phoenix.HTML.Form{
    impl: Phoenix.HTML.FormData.Atom,
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
             <span class="FormControl-radio-wrap">
             <input checked class="FormControl-radio" type="radio" value="" />
             </span>
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
             <span class="FormControl-radio-wrap">
             <input class="FormControl-radio" id="role_admin" name="role" type="radio" value="admin" />
             <span class="FormControl-radio-labelWrap"><label class="FormControl-label" for="role_admin">Admin</label></span>
             </span>
             <span class="FormControl-radio-wrap">
             <input class="FormControl-radio" id="role_editor" name="role" type="radio" value="editor" />
             <span class="FormControl-radio-labelWrap"><label class="FormControl-label" for="role_editor">Editor</label></span>
             </span>
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
             <span class="FormControl-radio-wrap"><input class="FormControl-radio" id="user_role_admin" name="user[role]" type="radio" value="admin" />
             <span class="FormControl-radio-labelWrap"><label class="FormControl-label" for="user_role_admin">Admin</label></span>
             </span>
             <span class="FormControl-radio-wrap"><input class="FormControl-radio" id="user_role_editor" name="user[role]" type="radio" value="editor" />
             <span class="FormControl-radio-labelWrap"><label class="FormControl-label" for="user_role_editor">Editor</label></span>
             </span>
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
             <span class="FormControl-radio-wrap"><input class="FormControl-radio" id="user_role_admin" name="user[role]" type="radio" value="admin" />
             <span class="FormControl-radio-labelWrap"><label class="FormControl-label" for="user_role_admin">Admin</label></span>
             </span>
             <span class="FormControl-radio-wrap"><input class="FormControl-radio" id="user_role_editor" name="user[role]" type="radio" value="editor" />
             <span class="FormControl-radio-labelWrap"><label class="FormControl-label" for="user_role_editor">Editor</label></span>
             </span>
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
             <span class="FormControl-radio-wrap"><input class="FormControl-radio" id="role_admin" name="role" type="radio" value="admin" />
             <span class="FormControl-radio-labelWrap"><label class="FormControl-label" for="role_admin">Admin</label></span>
             </span>
             <span class="FormControl-radio-wrap"><input class="FormControl-radio" id="role_editor" name="role" type="radio" value="editor" />
             <span class="FormControl-radio-labelWrap"><label class="FormControl-label" for="role_editor">Editor</label></span>
             </span>
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
             <span class="FormControl-radio-wrap">
             <input class="FormControl-radio" id="types_x" name="types" type="radio" value="x" /><span class="FormControl-radio-labelWrap"><label class="FormControl-label" for="types_x">X</label></span>
             </span>
             <span class="FormControl-radio-wrap">
             <input class="FormControl-radio" id="types_color" name="types" type="radio" value="color" /><span class="FormControl-radio-labelWrap"><label class="FormControl-label" for="types_color">Color</label></span>
             </span>
             <span class="FormControl-radio-wrap">
             <input class="FormControl-radio" id="types_date" name="types" type="radio" value="date" /><span class="FormControl-radio-labelWrap"><label class="FormControl-label" for="types_date">Date</label></span>
             </span>
             <span class="FormControl-radio-wrap">
             <input class="FormControl-radio" id="types_datetime-local" name="types" type="radio" value="datetime-local" />
             <span class="FormControl-radio-labelWrap"><label class="FormControl-label" for="types_datetime-local">Datetime-local</label></span>
             </span>
             <span class="FormControl-radio-wrap">
             <input class="FormControl-radio" id="types_email" name="types" type="radio" value="email" /><span class="FormControl-radio-labelWrap"><label class="FormControl-label" for="types_email">Email</label></span>
             </span>
             <span class="FormControl-radio-wrap">
             <input class="FormControl-radio" id="types_file" name="types" type="radio" value="file" /><span class="FormControl-radio-labelWrap"><label class="FormControl-label" for="types_file">File</label></span>
             </span>
             <span class="FormControl-radio-wrap">
             <input class="FormControl-radio" id="types_hidden" name="types" type="radio" value="hidden" /><span class="FormControl-radio-labelWrap"><label class="FormControl-label" for="types_hidden">Hidden</label></span>
             </span>
             <span class="FormControl-radio-wrap">
             <input class="FormControl-radio" id="types_number" name="types" type="radio" value="number" /><span class="FormControl-radio-labelWrap"><label class="FormControl-label" for="types_number">Number</label></span>
             </span>
             <span class="FormControl-radio-wrap">
             <input class="FormControl-radio" id="types_password" name="types" type="radio" value="password" /><span class="FormControl-radio-labelWrap"><label class="FormControl-label" for="types_password">Password</label></span>
             </span>
             <span class="FormControl-radio-wrap">
             <input class="FormControl-radio" id="types_range" name="types" type="radio" value="range" /><span class="FormControl-radio-labelWrap"><label class="FormControl-label" for="types_range">Range</label></span>
             </span>
             <span class="FormControl-radio-wrap">
             <input class="FormControl-radio" id="types_search" name="types" type="radio" value="search" /><span class="FormControl-radio-labelWrap"><label class="FormControl-label" for="types_search">Search</label></span>
             </span>
             <span class="FormControl-radio-wrap">
             <input class="FormControl-radio" id="types_telephone" name="types" type="radio" value="telephone" /><span class="FormControl-radio-labelWrap"><label class="FormControl-label" for="types_telephone">Telephone</label></span>
             </span>
             <span class="FormControl-radio-wrap">
             <input class="FormControl-radio" id="types_text" name="types" type="radio" value="text" /><span class="FormControl-radio-labelWrap"><label class="FormControl-label" for="types_text">Text</label></span>
             </span>
             <span class="FormControl-radio-wrap">
             <input class="FormControl-radio" id="types_textarea" name="types" type="radio" value="textarea" /><span class="FormControl-radio-labelWrap"><label class="FormControl-label" for="types_textarea">Textarea</label></span>
             </span>
             <span class="FormControl-radio-wrap">
             <input class="FormControl-radio" id="types_time" name="types" type="radio" value="time" /><span class="FormControl-radio-labelWrap"><label class="FormControl-label" for="types_time">Time</label></span>
             </span>
             <span class="FormControl-radio-wrap">
             <input class="FormControl-radio" id="types_url" name="types" type="radio" value="url" /><span class="FormControl-radio-labelWrap"><label class="FormControl-label" for="types_url">Url</label></span>
             </span>

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
             <span class="FormControl-radio-wrap"><input class="FormControl-radio" id="role_admin" name="role" type="radio" value="admin" />
             <span class="FormControl-radio-labelWrap"><label class="FormControl-label" for="role_admin">Admin</label></span>
             </span>
             <span class="FormControl-radio-wrap"><input checked class="FormControl-radio" id="role_editor" name="role" type="radio" value="editor" />
             <span class="FormControl-radio-labelWrap"><label class="FormControl-label" for="role_editor">Editor</label></span>
             </span>
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
                 container: "container-x",
                 label_container: "label_container-x",
                 label: "label-x",
                 input: "input-x",
                 caption: "caption-x",
                 hint: "hint-x",
                 disclosure: "disclosure-x"
               }
             }
             form={@form}
             field={:role}
           >
             <:label class="my-label">Some label</:label>
             <:hint class="my-hint">Some hint</:hint>
             <:caption class="my-caption">Some caption</:caption>
             <:disclosure class="my-disclosure">Disclosed</:disclosure>
           </.radio_button>
           """)
           |> format_html() ==
             """
             <span class="FormControl-radio-wrap pl-neutral container-x my-radio-button"><input
             class="form-checkbox-details-trigger FormControl-radio input-x" id="user_role" name="user[role]" type="radio"
             value="" /><span class="FormControl-radio-labelWrap label_container-x"><label aria-live="polite"
             class="FormControl-label label-x my-label" for="user_role">Some label</label><span
             class="FormControl-caption caption-x my-caption">Some caption</span><span
             class="form-checkbox-details text-normal disclosure-x my-disclosure">Disclosed</span></span></span>
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
             <span class="FormControl-radio-wrap"><input checked class="FormControl-radio" id="role" name="role" tabindex="1" type="radio" value="" /></span>
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
             <span class="FormControl-radio-wrap"><input checked class="FormControl-radio" id="role" name="role" type="radio"
             value="" /><span class="FormControl-radio-labelWrap"><label class="FormControl-label" dir="rtl" for="role">Some
             label</label></span></span>
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
             <span class="FormControl-radio-wrap"><input checked class="FormControl-radio" id="role" name="role" type="radio" value="" />
             <span class="FormControl-radio-labelWrap"><label class="FormControl-label" for="role"><em class="highlight">Some label</em></label></span>
             </span>
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
             <span class="FormControl-radio-wrap"><input checked class="form-checkbox-details-trigger FormControl-radio" id="role"
             name="role" type="radio" value="" /><span class="FormControl-radio-labelWrap"><label aria-live="polite"
             class="FormControl-label" for="role">Some label</label><span
             class="form-checkbox-details text-normal"><span>disclosure content</span></span></span></span>
             """
             |> format_html()
  end

  test "Hint slot (deprecated)" do
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
             <span class="FormControl-radio-wrap"><input checked class="FormControl-radio" id="role" name="role" type="radio" value="" />
             <span class="FormControl-radio-labelWrap"><label class="FormControl-label" for="role">Some label</label>
             <span class="FormControl-caption">Add your<strong>resume</strong>below</span>
             </span>
             </span>
             """
             |> format_html()
  end

  test "Caption slot" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.radio_button name="role">
             <:label>
               Some label
             </:label>
             <:caption>
               Add your <strong>resume</strong> below
             </:caption>
           </.radio_button>
           """)
           |> format_html() ==
             """
             <span class="FormControl-radio-wrap"><input checked class="FormControl-radio" id="role" name="role" type="radio" value="" />
             <span class="FormControl-radio-labelWrap"><label class="FormControl-label" for="role">Some label</label>
             <span class="FormControl-caption">Add your<strong>resume</strong>below</span>
             </span>
             </span>
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
             <span class="FormControl-radio-wrap"><input checked class="FormControl-radio" id="role" name="role" type="radio" value="" /></span>
             """
             |> format_html()
  end
end
