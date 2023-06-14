defmodule PrimerLive.TestComponents.CheckboxTest do
  use ExUnit.Case
  use PrimerLive
  import PrimerLive.Helpers.TestHelpers

  import Phoenix.Component
  import Phoenix.LiveViewTest

  @default_form %Phoenix.HTML.Form{
    impl: Phoenix.HTML.FormData.Atom,
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
             <input class="FormControl-checkbox" id="user[available_for_hire]" name="user[available_for_hire]" type="checkbox" value="true" />
             <span class="FormControl-checkbox-labelWrap">
             <label class="FormControl-label" for="user[available_for_hire]">Available for hire</label>
             </span>
             </span>
             """
             |> format_html()
  end

  test "Attribute: field as string" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.checkbox form={:user} field="available_for_hire" />
           """)
           |> format_html() ==
             """
             <span class="FormControl-checkbox-wrap">
             <input name="user[available_for_hire]" type="hidden" value="false" />
             <input class="FormControl-checkbox" id="user[available_for_hire]" name="user[available_for_hire]" type="checkbox" value="true" />
             <span class="FormControl-checkbox-labelWrap">
             <label class="FormControl-label" for="user[available_for_hire]">Available for hire</label>
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

  test "Multiple" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.checkbox form={:user} name="interest" checked_value="coding" />
           <.checkbox form={:user} name="interest" checked_value="music" />
           """)
           |> format_html() ==
             """
             <span class="FormControl-checkbox-wrap">
             <input name="user[interest]" type="hidden" value="false" />
             <input class="FormControl-checkbox" id="user[interest][coding]" name="user[interest]" type="checkbox" value="coding" />
             <span class="FormControl-checkbox-labelWrap"><label class="FormControl-label" for="user[interest][coding]">Coding</label></span>
             </span>
             <span class="FormControl-checkbox-wrap">
             <input name="user[interest]" type="hidden" value="false" />
             <input class="FormControl-checkbox" id="user[interest][music]" name="user[interest]" type="checkbox" value="music" />
             <span class="FormControl-checkbox-labelWrap"><label class="FormControl-label" for="user[interest][music]">Music</label></span>
             </span>

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
                 hint: "hint-x",
                 disclosure: "disclosure-x"
               }
             }
             form={@form}
             field={:available_for_hire}
           >
             <:label class="my-label">Some label</:label>
             <:hint class="my-hint">Some hint</:hint>
             <:disclosure class="my-disclosure">Some hint</:disclosure>
           </.checkbox>
           """)
           |> format_html() ==
             """
             <span class="FormControl-checkbox-wrap pl-neutral container-x my-checkbox">
             <input name="user[available_for_hire]" type="hidden" value="false" />
             <input checked class="form-checkbox-details-trigger FormControl-checkbox input-x"
             id="user[available_for_hire]" name="user[available_for_hire]" type="checkbox" value="true" />
             <span class="FormControl-checkbox-labelWrap label_container-x">
             <label class="FormControl-label label-x my-label" aria-live="polite"
             for="user[available_for_hire]">Some label</label>
             <span class="FormControl-caption hint-x my-hint">Some hint</span>
             <span class="form-checkbox-details text-normal disclosure-x my-disclosure">Some hint</span>
             </span>
             </span>
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
             <input class="FormControl-checkbox" id="role[editor]" name="role" type="checkbox" value="true" />
             <span class="FormControl-checkbox-labelWrap"><label class="FormControl-label" for="role[editor]">Editor</label></span>
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
             <input class="FormControl-checkbox" id="role[editor]" name="role" type="checkbox" value="editor" />
             <span class="FormControl-checkbox-labelWrap"><label class="FormControl-label" for="role[editor]">Editor</label></span>
             </span>

             <span class="FormControl-checkbox-wrap">
             <input name="role" type="hidden" value="false" />
             <input checked class="FormControl-checkbox" id="role[editor]" name="role" type="checkbox" value="editor" />
             <span class="FormControl-checkbox-labelWrap"><label class="FormControl-label" for="role[editor]">Editor</label></span>
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
             <span class="FormControl-checkbox-wrap">
             <input name="available_for_hire" type="hidden" value="false" />
             <input class="FormControl-checkbox" id="available_for_hire" name="available_for_hire" type="checkbox" value="true" />
             <span class="FormControl-checkbox-labelWrap"><label dir="rtl" class="FormControl-label" for="available_for_hire">Some label</label></span>
             </span>
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
             <span class="FormControl-checkbox-wrap">
             <input name="available_for_hire" type="hidden" value="false" />
             <input class="form-checkbox-details-trigger FormControl-checkbox" id="available_for_hire" name="available_for_hire" type="checkbox" value="true" />
             <span class="FormControl-checkbox-labelWrap"><label class="FormControl-label" aria-live="polite" for="available_for_hire">Some label</label><span class="form-checkbox-details text-normal"><span>disclosure content</span></span></span>
             </span>
             """
             |> format_html()
  end

  test "Hint slot" do
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

  test "Hint slot without label (not shown)" do
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
end
