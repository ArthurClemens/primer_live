defmodule PrimerLive.TestComponents.CheckboxInGroupTest do
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

  test "Attribute: field as string: should render with is_multiple" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.checkbox_in_group field="available_for_hire" />
           """)
           |> format_html() ==
             """
             <div class="FormControl-checkbox-wrap"><input name="[available_for_hire][]" type="hidden" value="false" /><input class="FormControl-checkbox" id="available-for-hire" name="[available_for_hire][]" type="checkbox" value="true" /><div class="FormControl-checkbox-labelWrap"><label class="FormControl-label" for="available-for-hire">Available for hire</label></div></div>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end

  test "Form atom and field as string: should render with is_multiple" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.checkbox_in_group form={:user} field="available_for_hire" />
           """)
           |> format_html() ==
             """
             <div class="FormControl-checkbox-wrap"><input name="user[available_for_hire][]" type="hidden" value="false" /><input class="FormControl-checkbox" id="user-available-for-hire" name="user[available_for_hire][]" type="checkbox" value="true" /><div class="FormControl-checkbox-labelWrap"><label class="FormControl-label" for="user-available-for-hire">Available for hire</label></div></div>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
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
             <div class="FormControl-checkbox-wrap"><input name="user[available_for_hire][]" type="hidden" value="false" /><input class="FormControl-checkbox" id="user-available-for-hire-coding" name="user[available_for_hire][]" type="checkbox" value="coding" /><div class="FormControl-checkbox-labelWrap"><label class="FormControl-label" for="user-available-for-hire-coding">Coding</label></div></div><div class="FormControl-checkbox-wrap"><input name="user[available_for_hire][]" type="hidden" value="false" /><input class="FormControl-checkbox" id="user-available-for-hire-music" name="user[available_for_hire][]" type="checkbox" value="music" /><div class="FormControl-checkbox-labelWrap"><label class="FormControl-label" for="user-available-for-hire-music">Music</label></div></div>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end
end
