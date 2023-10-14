defmodule PrimerLive.TestComponents.CheckboxTest do
  use ExUnit.Case
  use PrimerLive
  import PrimerLive.Helpers.TestHelpers

  import Phoenix.Component
  import Phoenix.LiveViewTest

  @default_form %Phoenix.HTML.Form{
    impl: Phoenix.HTML.FormData.Ecto.Changeset,
    id: "user",
    name: "user",
    params: %{"available_for_hire" => "true"},
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
           <.checkbox />
           """)
           |> format_html() ==
             """
             <span class="FormControl-checkbox-wrap">
             <input type="hidden" value="false" />
             <input class="FormControl-checkbox" type="checkbox" value="true" />
             </span>
             """
             |> format_html()
  end

  test "Called with invalid form value" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.checkbox form="x" />
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
           <.checkbox form={:user} field={:available_for_hire} />
           """)
           |> format_html() ==
             """
             <span class="FormControl-checkbox-wrap">
             <input name="user[available_for_hire]" type="hidden" value="false" />
             <input class="FormControl-checkbox" id="user_available_for_hire" name="user[available_for_hire]" type="checkbox" value="true" />
             <span class="FormControl-checkbox-labelWrap">
             <label class="FormControl-label" for="user_available_for_hire">Available for hire</label>
             </span>
             </span>
             """
             |> format_html()
  end

  test "Attribute: field as string" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.checkbox field="available_for_hire" />
           """)
           |> format_html() ==
             """
             <span class="FormControl-checkbox-wrap">
             <input name="[available_for_hire]" type="hidden" value="false" />
             <input class="FormControl-checkbox" id="available_for_hire" name="[available_for_hire]" type="checkbox" value="true" />
             <span class="FormControl-checkbox-labelWrap">
             <label class="FormControl-label" for="available_for_hire">Available for hire</label>
             </span>
             </span>
             """
             |> format_html()
  end

  test "Attribute: input_id" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.checkbox form={:user} field={:available_for_hire} input_id="xyz" />
           """)
           |> format_html() ==
             """
             <span class="FormControl-checkbox-wrap">
             <input name="user[available_for_hire]" type="hidden" value="false" />
             <input class="FormControl-checkbox" id="xyz" name="user[available_for_hire]" type="checkbox" value="true" />
             <span class="FormControl-checkbox-labelWrap">
             <label class="FormControl-label" for="xyz">Available for hire</label>
             </span>
             </span>
             """
             |> format_html()
  end

  test "Attribute: name only" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.checkbox name="available_for_hire" />
           """)
           |> format_html() ==
             """
             <span class="FormControl-checkbox-wrap">
             <input name="available_for_hire" type="hidden" value="false" />
             <input class="FormControl-checkbox" id="available_for_hire" name="available_for_hire" type="checkbox" value="true" />
             </span>
             """
             |> format_html()
  end

  test "Attribute: is_multiple" do
    assigns = %{
      form: @default_form
    }

    assert rendered_to_string(~H"""
           <.checkbox form={:user} field={:available_for_hire} checked_value="coding" is_multiple />
           <.checkbox form={:user} field={:available_for_hire} checked_value="music" is_multiple />
           """)
           |> format_html() ==
             """
             <span class="FormControl-checkbox-wrap"><input name="user[available_for_hire][]" type="hidden" value="false" /><input
             class="FormControl-checkbox" id="user_available_for_hire_coding" name="user[available_for_hire][]" type="checkbox"
             value="coding" /><span class="FormControl-checkbox-labelWrap"><label class="FormControl-label"
             for="user_available_for_hire_coding">Coding</label></span></span>
             <span class="FormControl-checkbox-wrap"><input name="user[available_for_hire][]" type="hidden" value="false" /><input
             class="FormControl-checkbox" id="user_available_for_hire_music" name="user[available_for_hire][]" type="checkbox"
             value="music" /><span class="FormControl-checkbox-labelWrap"><label class="FormControl-label"
             for="user_available_for_hire_music">Music</label></span></span>
             """
             |> format_html()
  end

  test "Attribute: types" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.checkbox name="input-type" type={:x} />
           <.checkbox name="input-type" type="color" />
           <.checkbox name="input-type" type="date" />
           <.checkbox name="input-type" type="datetime-local" />
           <.checkbox name="input-type" type="email" />
           <.checkbox name="input-type" type="file" />
           <.checkbox name="input-type" type="hidden" />
           <.checkbox name="input-type" type="number" />
           <.checkbox name="input-type" type="password" />
           <.checkbox name="input-type" type="range" />
           <.checkbox name="input-type" type="search" />
           <.checkbox name="input-type" type="telephone" />
           <.checkbox name="input-type" type="text" />
           <.checkbox name="input-type" type="textarea" />
           <.checkbox name="input-type" type="time" />
           <.checkbox name="input-type" type="url" />
           """)
           |> format_html() ==
             """
             <span class="FormControl-checkbox-wrap"><input name="input-type" type="hidden" value="false" /><input class="FormControl-checkbox" id="input-type" name="input-type" type="checkbox" value="true" /></span>
             <span class="FormControl-checkbox-wrap"><input name="input-type" type="hidden" value="false" /><input class="FormControl-checkbox" id="input-type" name="input-type" type="checkbox" value="true" /></span>
             <span class="FormControl-checkbox-wrap"><input name="input-type" type="hidden" value="false" /><input class="FormControl-checkbox" id="input-type" name="input-type" type="checkbox" value="true" /></span>
             <span class="FormControl-checkbox-wrap"><input name="input-type" type="hidden" value="false" /><input class="FormControl-checkbox" id="input-type" name="input-type" type="checkbox" value="true" /></span>
             <span class="FormControl-checkbox-wrap"><input name="input-type" type="hidden" value="false" /><input class="FormControl-checkbox" id="input-type" name="input-type" type="checkbox" value="true" /></span>
             <span class="FormControl-checkbox-wrap"><input name="input-type" type="hidden" value="false" /><input class="FormControl-checkbox" id="input-type" name="input-type" type="checkbox" value="true" /></span>
             <span class="FormControl-checkbox-wrap"><input name="input-type" type="hidden" value="false" /><input class="FormControl-checkbox" id="input-type" name="input-type" type="checkbox" value="true" /></span>
             <span class="FormControl-checkbox-wrap"><input name="input-type" type="hidden" value="false" /><input class="FormControl-checkbox" id="input-type" name="input-type" type="checkbox" value="true" /></span>
             <span class="FormControl-checkbox-wrap"><input name="input-type" type="hidden" value="false" /><input class="FormControl-checkbox" id="input-type" name="input-type" type="checkbox" value="true" /></span>
             <span class="FormControl-checkbox-wrap"><input name="input-type" type="hidden" value="false" /><input class="FormControl-checkbox" id="input-type" name="input-type" type="checkbox" value="true" /></span>
             <span class="FormControl-checkbox-wrap"><input name="input-type" type="hidden" value="false" /><input class="FormControl-checkbox" id="input-type" name="input-type" type="checkbox" value="true" /></span>
             <span class="FormControl-checkbox-wrap"><input name="input-type" type="hidden" value="false" /><input class="FormControl-checkbox" id="input-type" name="input-type" type="checkbox" value="true" /></span>
             <span class="FormControl-checkbox-wrap"><input name="input-type" type="hidden" value="false" /><input class="FormControl-checkbox" id="input-type" name="input-type" type="checkbox" value="true" /></span>
             <span class="FormControl-checkbox-wrap"><input name="input-type" type="hidden" value="false" /><input class="FormControl-checkbox" id="input-type" name="input-type" type="checkbox" value="true" /></span>
             <span class="FormControl-checkbox-wrap"><input name="input-type" type="hidden" value="false" /><input class="FormControl-checkbox" id="input-type" name="input-type" type="checkbox" value="true" /></span>
             <span class="FormControl-checkbox-wrap"><input name="input-type" type="hidden" value="false" /><input class="FormControl-checkbox" id="input-type" name="input-type" type="checkbox" value="true" /></span>
             """
             |> format_html()
  end

  test "Attribute: checked" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.checkbox name="available_for_hire" checked />
           """)
           |> format_html() ==
             """
             <span class="FormControl-checkbox-wrap">
             <input name="available_for_hire" type="hidden" value="false" />
             <input checked class="FormControl-checkbox" id="available_for_hire" name="available_for_hire" type="checkbox" value="true" />
             </span>
             """
             |> format_html()
  end

  test "Attribute: classes" do
    assigns = %{
      form: @default_form
    }

    assert rendered_to_string(~H"""
           <.checkbox
             class="my-checkbox"
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
             field={:available_for_hire}
           >
             <:label class="my-label">Some label</:label>
             <:hint class="my-hint">Some hint</:hint>
             <:caption class="my-caption">Some caption</:caption>
             <:disclosure class="my-disclosure">Disclosed</:disclosure>
           </.checkbox>
           """)
           |> format_html() ==
             """
             <span class="FormControl-checkbox-wrap pl-neutral container-x my-checkbox"><input name="user[available_for_hire]"
             type="hidden" value="false" /><input checked class="form-checkbox-details-trigger FormControl-checkbox input-x"
             id="user_available_for_hire" name="user[available_for_hire]" type="checkbox" value="true" /><span
             class="FormControl-checkbox-labelWrap label_container-x"><label aria-live="polite"
             class="FormControl-label label-x my-label" for="user_available_for_hire">Some label</label><span
             class="FormControl-caption caption-x my-caption">Some caption</span><span
             class="form-checkbox-details text-normal disclosure-x my-disclosure">Disclosed</span></span></span>
             """
             |> format_html()
  end

  test "Extra attributes: value" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.checkbox name="role" value="editor" />
           """)
           |> format_html() ==
             """
             <span class="FormControl-checkbox-wrap">
             <input name="role" type="hidden" value="false" />
             <input class="FormControl-checkbox" id="role_editor" name="role" type="checkbox" value="true" />
             <span class="FormControl-checkbox-labelWrap"><label class="FormControl-label" for="role_editor">Editor</label></span>
             </span>
             """
             |> format_html()
  end

  test "Extra attributes: checked_value" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.checkbox name="role" checked_value="editor" />
           <.checkbox name="role" checked_value="editor" value="editor" />
           """)
           |> format_html() ==
             """
             <span class="FormControl-checkbox-wrap">
             <input name="role" type="hidden" value="false" />
             <input class="FormControl-checkbox" id="role_editor" name="role" type="checkbox" value="editor" />
             <span class="FormControl-checkbox-labelWrap"><label class="FormControl-label" for="role_editor">Editor</label></span>
             </span>

             <span class="FormControl-checkbox-wrap">
             <input name="role" type="hidden" value="false" />
             <input checked class="FormControl-checkbox" id="role_editor" name="role" type="checkbox" value="editor" />
             <span class="FormControl-checkbox-labelWrap"><label class="FormControl-label" for="role_editor">Editor</label></span>
             </span>
             """
             |> format_html()
  end

  test "Extra attributes: tabindex" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.checkbox name="available_for_hire" tabindex="1" />
           """)
           |> format_html() ==
             """
             <span class="FormControl-checkbox-wrap">
             <input name="available_for_hire" type="hidden" value="false" />
             <input class="FormControl-checkbox" id="available_for_hire" name="available_for_hire" tabindex="1" type="checkbox" value="true" />
             </span>
             """
             |> format_html()
  end

  test "Label slot" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.checkbox name="available_for_hire">
             <:label dir="rtl">Some label</:label>
           </.checkbox>
           """)
           |> format_html() ==
             """
             <span class="FormControl-checkbox-wrap"><input name="available_for_hire" type="hidden" value="false" /><input
             class="FormControl-checkbox" id="available_for_hire" name="available_for_hire" type="checkbox"
             value="true" /><span class="FormControl-checkbox-labelWrap"><label class="FormControl-label" dir="rtl"
             for="available_for_hire">Some label</label></span></span>
             """
             |> format_html()
  end

  test "Label slot with attribute is_emphasised_label" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.checkbox name="available_for_hire" is_emphasised_label>
             <:label>Some label</:label>
           </.checkbox>
           """)
           |> format_html() ==
             """
             <span class="FormControl-checkbox-wrap">
             <input name="available_for_hire" type="hidden" value="false" />
             <input class="FormControl-checkbox" id="available_for_hire" name="available_for_hire" type="checkbox" value="true" />
             <span class="FormControl-checkbox-labelWrap"><label class="FormControl-label" for="available_for_hire"><em class="highlight">Some label</em></label></span>
             </span>
             """
             |> format_html()
  end

  test "Disclosure slot" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.checkbox name="available_for_hire">
             <:label>Some label</:label>
             <:disclosure>
               <span>disclosure content</span>
             </:disclosure>
           </.checkbox>
           """)
           |> format_html() ==
             """
             <span class="FormControl-checkbox-wrap"><input name="available_for_hire" type="hidden" value="false" /><input
             class="form-checkbox-details-trigger FormControl-checkbox" id="available_for_hire" name="available_for_hire"
             type="checkbox" value="true" /><span class="FormControl-checkbox-labelWrap"><label aria-live="polite"
             class="FormControl-label" for="available_for_hire">Some label</label><span
             class="form-checkbox-details text-normal"><span>disclosure content</span></span></span></span>
             """
             |> format_html()
  end

  test "Hint slot (deprecated)" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.checkbox name="available_for_hire">
             <:label>
               Some label
             </:label>
             <:hint>
               Add your <strong>resume</strong> below
             </:hint>
           </.checkbox>
           """)
           |> format_html() ==
             """
             <span class="FormControl-checkbox-wrap">
             <input name="available_for_hire" type="hidden" value="false" />
             <input class="FormControl-checkbox" id="available_for_hire" name="available_for_hire" type="checkbox" value="true" />
             <span class="FormControl-checkbox-labelWrap"><label class="FormControl-label" for="available_for_hire">Some label</label>
             <span class="FormControl-caption">Add your<strong>resume</strong>below</span>
             </span>
             </span>
             """
             |> format_html()
  end

  test "Hint slot without label (not shown) (deprecated)" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.checkbox name="available_for_hire">
             <:hint>
               Add your <strong>resume</strong> below
             </:hint>
           </.checkbox>
           """)
           |> format_html() ==
             """
             <span class="FormControl-checkbox-wrap">
             <input name="available_for_hire" type="hidden" value="false" />
             <input class="FormControl-checkbox" id="available_for_hire" name="available_for_hire" type="checkbox" value="true" />
             </span>
             """
             |> format_html()
  end

  test "Caption slot" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.checkbox name="available_for_hire">
             <:label>
               Some label
             </:label>
             <:caption>
               Add your <strong>resume</strong> below
             </:caption>
           </.checkbox>
           """)
           |> format_html() ==
             """
             <span class="FormControl-checkbox-wrap">
             <input name="available_for_hire" type="hidden" value="false" />
             <input class="FormControl-checkbox" id="available_for_hire" name="available_for_hire" type="checkbox" value="true" />
             <span class="FormControl-checkbox-labelWrap"><label class="FormControl-label" for="available_for_hire">Some label</label>
             <span class="FormControl-caption">Add your<strong>resume</strong>below</span>
             </span>
             </span>
             """
             |> format_html()
  end

  test "Caption slot without label (not shown)" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.checkbox name="available_for_hire">
             <:caption>
               Add your <strong>resume</strong> below
             </:caption>
           </.checkbox>
           """)
           |> format_html() ==
             """
             <span class="FormControl-checkbox-wrap">
             <input name="available_for_hire" type="hidden" value="false" />
             <input class="FormControl-checkbox" id="available_for_hire" name="available_for_hire" type="checkbox" value="true" />
             </span>
             """
             |> format_html()
  end
end
