defmodule PrimerLive.TestComponents.CheckboxTest do
  use ExUnit.Case
  use PrimerLive
  import PrimerLive.Helpers.TestHelpers

  import Phoenix.Component
  import Phoenix.LiveViewTest

  @default_form %Phoenix.HTML.Form{
    id: "user",
    name: "user",
    params: %{"available_for_hire" => ""},
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
             <div class="FormControl-checkbox-wrap">
             <input name="[]" type="hidden" value="false" />
             <input class="FormControl-checkbox" id="_" name="[]" type="checkbox" value="true" />
             </div>
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
             <div class="FormControl-checkbox-wrap">
             <input name="user[available_for_hire]" type="hidden" value="false" />
             <input class="FormControl-checkbox" id="user_available_for_hire_" name="user[available_for_hire]" type="checkbox" value="true" />
             <div class="FormControl-checkbox-labelWrap"><label class="FormControl-label" for="user_available_for_hire_">Available for hire</label></div>
             </div>
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
             <div class="FormControl-checkbox-wrap">
             <input name="user[available_for_hire]" type="hidden" value="false" />
             <input class="FormControl-checkbox" id="user_available_for_hire_" name="user[available_for_hire]" type="checkbox" value="true" />
             <div class="FormControl-checkbox-labelWrap"><label class="FormControl-label" for="user_available_for_hire_">Available for hire</label></div>
             </div>
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
             <div class="FormControl-checkbox-wrap">
             <input name="available_for_hire" type="hidden" value="false" />
             <input class="FormControl-checkbox" id="_available_for_hire_" name="available_for_hire" type="checkbox" value="true" />
             </div>
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
             <div class="FormControl-checkbox-wrap">
             <input name="interest" type="hidden" value="false" />
             <input class="FormControl-checkbox" id="user_interest_coding" name="interest" type="checkbox" value="coding" />
             <div class="FormControl-checkbox-labelWrap"><label class="FormControl-label" for="user_interest_coding">Coding</label></div>
             </div>
             <div class="FormControl-checkbox-wrap">
             <input name="interest" type="hidden" value="false" />
             <input class="FormControl-checkbox" id="user_interest_music" name="interest" type="checkbox" value="music" />
             <div class="FormControl-checkbox-labelWrap"><label class="FormControl-label" for="user_interest_music">Music</label></div>
             </div>
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
             <div class="FormControl-checkbox-wrap"><input name="input-type" type="hidden" value="false" /><input class="FormControl-checkbox" id="_input-type_" name="input-type" type="checkbox" value="true" /></div>
             <div class="FormControl-checkbox-wrap"><input name="input-type" type="hidden" value="false" /><input class="FormControl-checkbox" id="_input-type_" name="input-type" type="checkbox" value="true" /></div>
             <div class="FormControl-checkbox-wrap"><input name="input-type" type="hidden" value="false" /><input class="FormControl-checkbox" id="_input-type_" name="input-type" type="checkbox" value="true" /></div>
             <div class="FormControl-checkbox-wrap"><input name="input-type" type="hidden" value="false" /><input class="FormControl-checkbox" id="_input-type_" name="input-type" type="checkbox" value="true" /></div>
             <div class="FormControl-checkbox-wrap"><input name="input-type" type="hidden" value="false" /><input class="FormControl-checkbox" id="_input-type_" name="input-type" type="checkbox" value="true" /></div>
             <div class="FormControl-checkbox-wrap"><input name="input-type" type="hidden" value="false" /><input class="FormControl-checkbox" id="_input-type_" name="input-type" type="checkbox" value="true" /></div>
             <div class="FormControl-checkbox-wrap"><input name="input-type" type="hidden" value="false" /><input class="FormControl-checkbox" id="_input-type_" name="input-type" type="checkbox" value="true" /></div>
             <div class="FormControl-checkbox-wrap"><input name="input-type" type="hidden" value="false" /><input class="FormControl-checkbox" id="_input-type_" name="input-type" type="checkbox" value="true" /></div>
             <div class="FormControl-checkbox-wrap"><input name="input-type" type="hidden" value="false" /><input class="FormControl-checkbox" id="_input-type_" name="input-type" type="checkbox" value="true" /></div>
             <div class="FormControl-checkbox-wrap"><input name="input-type" type="hidden" value="false" /><input class="FormControl-checkbox" id="_input-type_" name="input-type" type="checkbox" value="true" /></div>
             <div class="FormControl-checkbox-wrap"><input name="input-type" type="hidden" value="false" /><input class="FormControl-checkbox" id="_input-type_" name="input-type" type="checkbox" value="true" /></div>
             <div class="FormControl-checkbox-wrap"><input name="input-type" type="hidden" value="false" /><input class="FormControl-checkbox" id="_input-type_" name="input-type" type="checkbox" value="true" /></div>
             <div class="FormControl-checkbox-wrap"><input name="input-type" type="hidden" value="false" /><input class="FormControl-checkbox" id="_input-type_" name="input-type" type="checkbox" value="true" /></div>
             <div class="FormControl-checkbox-wrap"><input name="input-type" type="hidden" value="false" /><input class="FormControl-checkbox" id="_input-type_" name="input-type" type="checkbox" value="true" /></div>
             <div class="FormControl-checkbox-wrap"><input name="input-type" type="hidden" value="false" /><input class="FormControl-checkbox" id="_input-type_" name="input-type" type="checkbox" value="true" /></div>
             <div class="FormControl-checkbox-wrap"><input name="input-type" type="hidden" value="false" /><input class="FormControl-checkbox" id="_input-type_" name="input-type" type="checkbox" value="true" /></div>
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
             <div class="FormControl-checkbox-wrap">
             <input name="available_for_hire" type="hidden" value="false" />
             <input checked class="FormControl-checkbox" id="_available_for_hire_" name="available_for_hire" type="checkbox" value="true" />
             </div>
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
             <div class="FormControl-checkbox-wrap container-x my-checkbox">
             <input name="user[available_for_hire]" type="hidden" value="false" />
             <input class="form-checkbox-details-trigger FormControl-checkbox input-x" id="user_available_for_hire_" name="user[available_for_hire]" type="checkbox" value="true" />
             <div class="FormControl-checkbox-labelWrap label_container-x"><label class="FormControl-label label-x my-label" aria-live="polite" for="user_available_for_hire_">Some label</label>
             <p class="FormControl-caption hint-x my-hint">Some hint</p><span class="form-checkbox-details text-normal disclosure-x my-disclosure">Some hint</span>
             </div>
             </div>
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
             <div class="FormControl-checkbox-wrap">
             <input name="role" type="hidden" value="false" />
             <input class="FormControl-checkbox" id="_role_editor" name="role" type="checkbox" value="true" />
             <div class="FormControl-checkbox-labelWrap"><label class="FormControl-label" for="_role_editor">Editor</label></div>
             </div>
             """
             |> format_html()
  end

  test "Extra attributes: checked_value" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.checkbox name="role" checked_value="editor" />
           """)
           |> format_html() ==
             """
             <div class="FormControl-checkbox-wrap">
             <input name="role" type="hidden" value="false" />
             <input class="FormControl-checkbox" id="_role_editor" name="role" type="checkbox" value="editor" />
             <div class="FormControl-checkbox-labelWrap"><label class="FormControl-label" for="_role_editor">Editor</label></div>
             </div>
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
             <div class="FormControl-checkbox-wrap">
             <input name="available_for_hire" type="hidden" value="false" />
             <input class="FormControl-checkbox" id="_available_for_hire_" name="available_for_hire" tabindex="1" type="checkbox" value="true" />
             </div>
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
             <div class="FormControl-checkbox-wrap">
             <input name="available_for_hire" type="hidden" value="false" />
             <input class="FormControl-checkbox" id="_available_for_hire_" name="available_for_hire" type="checkbox" value="true" />
             <div class="FormControl-checkbox-labelWrap"><label dir="rtl" class="FormControl-label" for="_available_for_hire_">Some label</label></div>
             </div>
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
             <div class="FormControl-checkbox-wrap">
             <input name="available_for_hire" type="hidden" value="false" />
             <input class="FormControl-checkbox" id="_available_for_hire_" name="available_for_hire" type="checkbox" value="true" />
             <div class="FormControl-checkbox-labelWrap"><label class="FormControl-label" for="_available_for_hire_"><em class="highlight">Some label</em></label></div>
             </div>
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
             <div class="FormControl-checkbox-wrap">
             <input name="available_for_hire" type="hidden" value="false" />
             <input class="form-checkbox-details-trigger FormControl-checkbox" id="_available_for_hire_" name="available_for_hire" type="checkbox" value="true" />
             <div class="FormControl-checkbox-labelWrap"><label class="FormControl-label" aria-live="polite" for="_available_for_hire_">Some label</label><span class="form-checkbox-details text-normal"><span>disclosure content</span></span></div>
             </div>
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
             <div class="FormControl-checkbox-wrap">
             <input name="available_for_hire" type="hidden" value="false" />
             <input class="FormControl-checkbox" id="_available_for_hire_" name="available_for_hire" type="checkbox" value="true" />
             <div class="FormControl-checkbox-labelWrap"><label class="FormControl-label" for="_available_for_hire_">Some label</label>
             <p class="FormControl-caption">Add your<strong>resume</strong>below</p>
             </div>
             </div>
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
             <div class="FormControl-checkbox-wrap">
             <input name="available_for_hire" type="hidden" value="false" />
             <input class="FormControl-checkbox" id="_available_for_hire_" name="available_for_hire" type="checkbox" value="true" />
             </div>
             """
             |> format_html()
  end
end
