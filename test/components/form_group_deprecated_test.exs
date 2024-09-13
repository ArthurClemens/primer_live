defmodule PrimerLive.TestComponents.FormGroupDeprecatedTest do
  use ExUnit.Case
  use PrimerLive

  import PrimerLive.Helpers.TestHelpers
  import Phoenix.Component
  import Phoenix.LiveViewTest

  alias PrimerLive.TestHelpers.Repo.Users

  test "Called without options : should render the component" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.form_group>inputs</.form_group>
           """)
           |> format_html() ==
             """
             <div class="FormControl form-group">inputs</div>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end

  test "Attribute: form and field (atoms)" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.form_group form={:user} field={:first_name}>inputs</.form_group>
           """)
           |> format_html() ==
             """
             <div class="FormControl form-group"><div class="form-group-header"><label class="FormControl-label" for="user-first-name">First name</label></div>inputs</div>
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
           <.form_group form={:user} field="first_name">inputs</.form_group>
           """)
           |> format_html() ==
             """
             <div class="FormControl form-group"><div class="form-group-header"><label class="FormControl-label" for="user-first-name">First name</label></div>inputs</div>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end

  test "Attribute: is_hide_label" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.form_group is_hide_label>inputs</.form_group>
           """)
           |> format_html() ==
             """
             <div class="FormControl form-group">inputs</div>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end

  test "Attribute: is_disabled" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.form_group is_disabled>inputs</.form_group>
           """)
           |> format_html() ==
             """
             <div class="FormControl form-group pl-FormControl-disabled">inputs</div>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end

  test "Extra attributes" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.form_group dir="rtl">inputs</.form_group>
           """)
           |> format_html() ==
             """
             <div class="FormControl form-group" dir="rtl">inputs</div>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end

  test "Classes" do
    changeset = Users.init()

    assigns = %{
      changeset: changeset,
      field: :first_name
    }

    assert rendered_to_string(~H"""
           <.form :let={f} for={@changeset}>
             <.form_group
               class="my-form-group"
               classes={
                 %{
                   control: "control-x",
                   group: "group-x",
                   header: "header-x",
                   label: "label-x"
                 }
               }
               form={f}
               field={@field}
             >
               inputs
             </.form_group>
           </.form>
           """)
           |> format_html() ==
             """
             <form method="post"><div class="FormControl form-group my-form-group group-x control-x pl-invalid"><div class="form-group-header header-x"><label class="FormControl-label label-x" for="user-first-name">First name</label><span aria-hidden="true">*</span></div>inputs</div></form>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end

  test "Checkboxes" do
    changeset = Users.init()

    assigns = %{
      changeset: changeset,
      field: :available_for_hire
    }

    assert rendered_to_string(~H"""
           <.form :let={f} for={@changeset}>
             <.form_group form={f} field={@field}>
               <.checkbox form={f} field={@field} checked_value="admin" />
               <.checkbox form={f} field={@field} checked_value="editor" />
             </.form_group>
           </.form>
           """)
           |> format_html() ==
             """
             <form method="post"><div class="FormControl form-group pl-invalid"><div class="form-group-header"><label class="FormControl-label" for="user-available-for-hire">Available for hire</label><span aria-hidden="true">*</span></div><div class="FormControl-checkbox-wrap pl-invalid"><input name="user[available_for_hire]" type="hidden" value="false" /><input class="FormControl-checkbox" id="user-available-for-hire-admin" name="user[available_for_hire]" type="checkbox" value="admin" /><div class="FormControl-checkbox-labelWrap"><label class="FormControl-label" for="user-available-for-hire-admin">Admin</label></div></div><div class="FormControl-checkbox-wrap pl-invalid"><input name="user[available_for_hire]" type="hidden" value="false" /><input class="FormControl-checkbox" id="user-available-for-hire-editor" name="user[available_for_hire]" type="checkbox" value="editor" /><div class="FormControl-checkbox-labelWrap"><label class="FormControl-label" for="user-available-for-hire-editor">Editor</label></div></div></div></form>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end
end
