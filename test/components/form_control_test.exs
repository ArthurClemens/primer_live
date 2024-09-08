defmodule PrimerLive.TestComponents.FormControlTest do
  use ExUnit.Case
  use PrimerLive

  import PrimerLive.Helpers.TestHelpers
  import Phoenix.Component
  import Phoenix.LiveViewTest

  alias PrimerLive.TestHelpers.Repo.Users

  test "Called without options: should render the component" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.form_control>inputs</.form_control>
           """)
           |> format_html() ==
             """
             <div class="FormControl">inputs</div>
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
           <.form_control form={:user} field={:first_name}>inputs</.form_control>
           """)
           |> format_html() ==
             """
             <div class="FormControl"><div class="form-group-header"><label class="FormControl-label" for="user-first-name">First name</label></div>inputs</div>
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
           <.form_control form={:user} field="first_name">inputs</.form_control>
           """)
           |> format_html() ==
             """
             <div class="FormControl"><div class="form-group-header"><label class="FormControl-label" for="user-first-name">First name</label></div>inputs</div>
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
           <.form_control is_hide_label>inputs</.form_control>
           """)
           |> format_html() ==
             """
             <div class="FormControl">inputs</div>
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
           <.form_control is_disabled>inputs</.form_control>
           """)
           |> format_html() ==
             """
             <div class="FormControl pl-FormControl-disabled">inputs</div>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end

  test "Attribute: required_marker" do
    changeset = Users.init()

    assigns = %{
      changeset: changeset,
      field: :first_name
    }

    assert rendered_to_string(~H"""
           <.form :let={f} for={@changeset}>
             <.form_control form={f} field={@field}>inputs</.form_control>
           </.form>

           <.form :let={f} for={@changeset}>
             <.form_control form={f} field={@field} required_marker="">inputs</.form_control>
           </.form>

           <.form :let={f} for={@changeset}>
             <.form_control form={f} field={@field} required_marker="required">inputs</.form_control>
           </.form>
           """)
           |> format_html() ==
             """
             <form method="post"><div class="FormControl pl-invalid"><div class="form-group-header"><label class="FormControl-label" for="user-first-name">First name</label><span aria-hidden="true">*</span></div>inputs</div></form><form method="post"><div class="FormControl pl-invalid"><div class="form-group-header"><label class="FormControl-label" for="user-first-name">First name</label></div>inputs</div></form><form method="post"><div class="FormControl pl-invalid"><div class="form-group-header"><label class="FormControl-label" for="user-first-name">First name</label><span aria-hidden="true">required</span></div>inputs</div></form>
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
           <.form_control dir="rtl">inputs</.form_control>
           """)
           |> format_html() ==
             """
             <div class="FormControl" dir="rtl">inputs</div>
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
             <.form_control
               class="my-form-control"
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
             </.form_control>
           </.form>
           """)
           |> format_html() ==
             """
             <form method="post"><div class="FormControl my-form-control group-x control-x pl-invalid"><div class="form-group-header header-x"><label class="FormControl-label label-x" for="user-first-name">First name</label><span aria-hidden="true">*</span></div>inputs</div></form>
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
             <.form_control form={f} field={@field}>
               <.checkbox form={f} field={@field} checked_value="admin" />
               <.checkbox form={f} field={@field} checked_value="editor" />
             </.form_control>
           </.form>
           """)
           |> format_html() ==
             """
             <form method="post"><div class="FormControl pl-invalid"><div class="form-group-header"><label class="FormControl-label" for="user-available-for-hire">Available for hire</label><span aria-hidden="true">*</span></div><span class="FormControl-checkbox-wrap pl-invalid"><input name="user[available_for_hire]" type="hidden" value="false" /><input class="FormControl-checkbox" id="user-available-for-hire-admin" name="user[available_for_hire]" type="checkbox" value="admin" /><span class="FormControl-checkbox-labelWrap"><label class="FormControl-label" for="user-available-for-hire-admin">Admin</label></span></span><span class="FormControl-checkbox-wrap pl-invalid"><input name="user[available_for_hire]" type="hidden" value="false" /><input class="FormControl-checkbox" id="user-available-for-hire-editor" name="user[available_for_hire]" type="checkbox" value="editor" /><span class="FormControl-checkbox-labelWrap"><label class="FormControl-label" for="user-available-for-hire-editor">Editor</label></span></span></div></form>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end
end
