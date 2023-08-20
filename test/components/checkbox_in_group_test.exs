defmodule PrimerLive.TestComponents.CheckboxInGroupTest do
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

  test "Attribute: field as string: should render with is_multiple" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.checkbox_in_group field="available_for_hire" />
           """)
           |> format_html() ==
             """
             <span class="FormControl-checkbox-wrap">
             <input name="[available_for_hire][]" type="hidden" value="false" />
             <input class="FormControl-checkbox" id="available_for_hire" name="[available_for_hire][]" type="checkbox" value="true" />
             <span class="FormControl-checkbox-labelWrap">
             <label class="FormControl-label" for="available_for_hire">Available for hire</label>
             </span>
             </span>
             """
             |> format_html()
  end

  test "Form atom and field as string: should render with is_multiple" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.checkbox_in_group form={:user} field="available_for_hire" />
           """)
           |> format_html() ==
             """
             <span class="FormControl-checkbox-wrap">
             <input name="user[available_for_hire][]" type="hidden" value="false" />
             <input class="FormControl-checkbox" id="user_available_for_hire" name="user[available_for_hire][]" type="checkbox" value="true" />
             <span class="FormControl-checkbox-labelWrap">
             <label class="FormControl-label" for="user_available_for_hire">Available for hire</label>
             </span>
             </span>
             """
             |> format_html()
  end

  test "Phoenix form: should render with is_multiple" do
    assigns = %{
      form: @default_form
    }

    assert rendered_to_string(~H"""
           <.checkbox_in_group form={:user} field={:available_for_hire} checked_value="coding" />
           <.checkbox_in_group form={:user} field={:available_for_hire} checked_value="music" />
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
end
