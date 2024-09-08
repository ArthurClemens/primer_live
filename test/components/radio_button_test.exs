defmodule PrimerLive.TestComponents.RadioButtonTest do
  use ExUnit.Case
  use PrimerLive
  import PrimerLive.Helpers.TestHelpers

  import Phoenix.Component
  import Phoenix.LiveViewTest

  @default_form %Phoenix.HTML.Form{
    impl: Phoenix.HTML.FormData.Ecto.Changeset,
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
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
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
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end

  test "Extra attributes: value" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.radio_button name="role" value="admin" />
           <.radio_button name="role" value="editor" />
           """)
           |> format_html() ==
             """
             <span class="FormControl-radio-wrap"><input class="FormControl-radio" id="role-admin" name="role" type="radio" value="admin" /><span class="FormControl-radio-labelWrap"><label class="FormControl-label" for="role-admin">Admin</label></span></span><span class="FormControl-radio-wrap"><input class="FormControl-radio" id="role-editor" name="role" type="radio" value="editor" /><span class="FormControl-radio-labelWrap"><label class="FormControl-label" for="role-editor">Editor</label></span></span>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end

  test "Attribute: form, field and value" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.radio_button form={:user} field={:role} value="admin" />
           <.radio_button form={:user} field={:role} value="editor" />
           """)
           |> format_html() ==
             """
             <span class="FormControl-radio-wrap"><input class="FormControl-radio" id="user-role-admin" name="user[role]" type="radio" value="admin" /><span class="FormControl-radio-labelWrap"><label class="FormControl-label" for="user-role-admin">Admin</label></span></span><span class="FormControl-radio-wrap"><input class="FormControl-radio" id="user-role-editor" name="user[role]" type="radio" value="editor" /><span class="FormControl-radio-labelWrap"><label class="FormControl-label" for="user-role-editor">Editor</label></span></span>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end

  test "Attribute: field as string" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.radio_button form={:user} field="role" value="admin" />
           <.radio_button form={:user} field="role" value="editor" />
           """)
           |> format_html() ==
             """
             <span class="FormControl-radio-wrap"><input class="FormControl-radio" id="user-role-admin" name="user[role]" type="radio" value="admin" /><span class="FormControl-radio-labelWrap"><label class="FormControl-label" for="user-role-admin">Admin</label></span></span><span class="FormControl-radio-wrap"><input class="FormControl-radio" id="user-role-editor" name="user[role]" type="radio" value="editor" /><span class="FormControl-radio-labelWrap"><label class="FormControl-label" for="user-role-editor">Editor</label></span></span>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end

  test "Attribute: name only" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.radio_button name="role" value="admin" />
           <.radio_button name="role" value="editor" />
           """)
           |> format_html() ==
             """
             <span class="FormControl-radio-wrap"><input class="FormControl-radio" id="role-admin" name="role" type="radio" value="admin" />
             <span class="FormControl-radio-labelWrap"><label class="FormControl-label" for="role-admin">Admin</label></span>
             </span>
             <span class="FormControl-radio-wrap"><input class="FormControl-radio" id="role-editor" name="role" type="radio" value="editor" />
             <span class="FormControl-radio-labelWrap"><label class="FormControl-label" for="role-editor">Editor</label></span>
             </span>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
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
             <span class="FormControl-radio-wrap"><input class="FormControl-radio" id="types-x" name="types" type="radio" value="x" /><span class="FormControl-radio-labelWrap"><label class="FormControl-label" for="types-x">X</label></span></span><span class="FormControl-radio-wrap"><input class="FormControl-radio" id="types-color" name="types" type="radio" value="color" /><span class="FormControl-radio-labelWrap"><label class="FormControl-label" for="types-color">Color</label></span></span><span class="FormControl-radio-wrap"><input class="FormControl-radio" id="types-date" name="types" type="radio" value="date" /><span class="FormControl-radio-labelWrap"><label class="FormControl-label" for="types-date">Date</label></span></span><span class="FormControl-radio-wrap"><input class="FormControl-radio" id="types-datetime-local" name="types" type="radio" value="datetime-local" /><span class="FormControl-radio-labelWrap"><label class="FormControl-label" for="types-datetime-local">Datetime-local</label></span></span><span class="FormControl-radio-wrap"><input class="FormControl-radio" id="types-email" name="types" type="radio" value="email" /><span class="FormControl-radio-labelWrap"><label class="FormControl-label" for="types-email">Email</label></span></span><span class="FormControl-radio-wrap"><input class="FormControl-radio" id="types-file" name="types" type="radio" value="file" /><span class="FormControl-radio-labelWrap"><label class="FormControl-label" for="types-file">File</label></span></span><span class="FormControl-radio-wrap"><input class="FormControl-radio" id="types-hidden" name="types" type="radio" value="hidden" /><span class="FormControl-radio-labelWrap"><label class="FormControl-label" for="types-hidden">Hidden</label></span></span><span class="FormControl-radio-wrap"><input class="FormControl-radio" id="types-number" name="types" type="radio" value="number" /><span class="FormControl-radio-labelWrap"><label class="FormControl-label" for="types-number">Number</label></span></span><span class="FormControl-radio-wrap"><input class="FormControl-radio" id="types-password" name="types" type="radio" value="password" /><span class="FormControl-radio-labelWrap"><label class="FormControl-label" for="types-password">Password</label></span></span><span class="FormControl-radio-wrap"><input class="FormControl-radio" id="types-range" name="types" type="radio" value="range" /><span class="FormControl-radio-labelWrap"><label class="FormControl-label" for="types-range">Range</label></span></span><span class="FormControl-radio-wrap"><input class="FormControl-radio" id="types-search" name="types" type="radio" value="search" /><span class="FormControl-radio-labelWrap"><label class="FormControl-label" for="types-search">Search</label></span></span><span class="FormControl-radio-wrap"><input class="FormControl-radio" id="types-telephone" name="types" type="radio" value="telephone" /><span class="FormControl-radio-labelWrap"><label class="FormControl-label" for="types-telephone">Telephone</label></span></span><span class="FormControl-radio-wrap"><input class="FormControl-radio" id="types-text" name="types" type="radio" value="text" /><span class="FormControl-radio-labelWrap"><label class="FormControl-label" for="types-text">Text</label></span></span><span class="FormControl-radio-wrap"><input class="FormControl-radio" id="types-textarea" name="types" type="radio" value="textarea" /><span class="FormControl-radio-labelWrap"><label class="FormControl-label" for="types-textarea">Textarea</label></span></span><span class="FormControl-radio-wrap"><input class="FormControl-radio" id="types-time" name="types" type="radio" value="time" /><span class="FormControl-radio-labelWrap"><label class="FormControl-label" for="types-time">Time</label></span></span><span class="FormControl-radio-wrap"><input class="FormControl-radio" id="types-url" name="types" type="radio" value="url" /><span class="FormControl-radio-labelWrap"><label class="FormControl-label" for="types-url">Url</label></span></span>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end

  test "Attribute: checked" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.radio_button name="role" value="admin" />
           <.radio_button name="role" value="editor" checked />
           """)
           |> format_html() ==
             """
             <span class="FormControl-radio-wrap"><input class="FormControl-radio" id="role-admin" name="role" type="radio" value="admin" />
             <span class="FormControl-radio-labelWrap"><label class="FormControl-label" for="role-admin">Admin</label></span>
             </span>
             <span class="FormControl-radio-wrap"><input checked class="FormControl-radio" id="role-editor" name="role" type="radio" value="editor" />
             <span class="FormControl-radio-labelWrap"><label class="FormControl-label" for="role-editor">Editor</label></span>
             </span>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
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
             <span class="FormControl-radio-wrap pl-neutral container-x my-radio-button"><input class="form-checkbox-details-trigger FormControl-radio input-x" id="user-role" name="user[role]" type="radio" value="" /><span class="FormControl-radio-labelWrap label_container-x"><label aria-live="polite" class="FormControl-label label-x my-label" for="user-role">Some label</label><span class="FormControl-caption caption-x my-caption">Some caption</span><span class="form-checkbox-details text-normal disclosure-x my-disclosure">Disclosed</span></span></span>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
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
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
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
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
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
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
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
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
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
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
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
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
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
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end
end
