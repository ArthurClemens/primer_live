defmodule PrimerLive.Components.FormTestInputTest do
  use ExUnit.Case
  use PrimerLive
  import PrimerLive.Helpers.TestHelpers

  import Phoenix.LiveView.Helpers
  import Phoenix.LiveViewTest

  test "Called without options or inner_block: should render the component" do
    assigns = []

    assert rendered_to_string(~H"""
           <.text_input />
           """)
           |> format_html() ==
             """
             <input class="form-control" id="_" name="[]" type="text" />
             """
             |> format_html()
  end

  test "Option: form and field (atoms)" do
    assigns = []

    assert rendered_to_string(~H"""
           <.text_input form={:user} field={:first_name} />
           """)
           |> format_html() ==
             """
             <input class="form-control" id="user_first_name" name="user[first_name]" type="text" />
             """
             |> format_html()
  end

  test "Option: form as string" do
    assigns = []

    assert rendered_to_string(~H"""
           <.text_input form="user" field={:first_name} />
           """)
           |> format_html() ==
             """
             <div class="flash flash-error"><p>text_input component received invalid options:</p><p>form: Invalid type</p></div>
             """
             |> format_html()
  end

  test "Option: field as string" do
    assigns = []

    assert rendered_to_string(~H"""
           <.text_input form={:user} field="first_name" />
           """)
           |> format_html() ==
             """
             <input class="form-control" id="user_first_name" name="user[first_name]" type="text" />
             """
             |> format_html()
  end

  test "Option: name only" do
    assigns = []

    assert rendered_to_string(~H"""
           <.text_input name="first_name" />
           """)
           |> format_html() ==
             """
             <input class="form-control" id="_" name="first_name" type="text" />
             """
             |> format_html()
  end

  test "Option: type (invalid)" do
    assigns = []

    assert rendered_to_string(~H"""
           <.text_input type={:x} />
           """)
           |> format_html() ==
             """
             <div class="flash flash-error"><p>text_input component received invalid options:</p><p>type: is invalid</p></div>
             """
             |> format_html()
  end

  test "Option: type (text)" do
    assigns = []

    assert rendered_to_string(~H"""
           <.text_input type="text" />
           """)
           |> format_html() ==
             """
             <input class="form-control" id="_" name="[]" type="text" />
             """
             |> format_html()
  end

  test "Option: type (password)" do
    assigns = []

    assert rendered_to_string(~H"""
           <.text_input type="password" />
           """)
           |> format_html() ==
             """
             <input class="form-control" id="_" name="[]" type="password" />
             """
             |> format_html()
  end

  test "Option: type (email)" do
    assigns = []

    assert rendered_to_string(~H"""
           <.text_input type="email" />
           """)
           |> format_html() ==
             """
             <input class="form-control" id="_" name="[]" type="email" />
             """
             |> format_html()
  end

  test "Option: type (search)" do
    assigns = []

    assert rendered_to_string(~H"""
           <.text_input type="search" />
           """)
           |> format_html() ==
             """
             <input class="form-control" id="_" name="[]" type="search" />
             """
             |> format_html()
  end

  test "Option: type (url)" do
    assigns = []

    assert rendered_to_string(~H"""
           <.text_input type="url" />
           """)
           |> format_html() ==
             """
             <input class="form-control" id="_" name="[]" type="url" />
             """
             |> format_html()
  end

  test "Option: is_contrast" do
    assigns = []

    assert rendered_to_string(~H"""
           <.text_input is_contrast />
           """)
           |> format_html() ==
             """
             <input class="form-control input-contrast" id="_" name="[]" type="text" />
             """
             |> format_html()
  end

  test "Option: is_full_width" do
    assigns = []

    assert rendered_to_string(~H"""
           <.text_input is_full_width />
           """)
           |> format_html() ==
             """
             <input class="form-control input-block" id="_" name="[]" type="text" />
             """
             |> format_html()
  end

  test "Option: is_hide_webkit_autofill" do
    assigns = []

    assert rendered_to_string(~H"""
           <.text_input is_hide_webkit_autofill />
           """)
           |> format_html() ==
             """
             <input class="form-control input-hide-webkit-autofill" id="_" name="[]" type="text" />
             """
             |> format_html()
  end

  test "Option: is_large" do
    assigns = []

    assert rendered_to_string(~H"""
           <.text_input is_large />
           """)
           |> format_html() ==
             """
             <input class="form-control input-lg" id="_" name="[]" type="text" />
             """
             |> format_html()
  end

  test "Option: is_small" do
    assigns = []

    assert rendered_to_string(~H"""
           <.text_input is_small />
           """)
           |> format_html() ==
             """
             <input class="form-control input-sm" id="_" name="[]" type="text" />
             """
             |> format_html()
  end

  test "Option: class" do
    assigns = []

    assert rendered_to_string(~H"""
           <.text_input class="x" />
           """)
           |> format_html() ==
             """
             <input class="form-control x" id="_" name="[]" type="text" />
             """
             |> format_html()
  end

  test "Extra attributes" do
    assigns = []

    assert rendered_to_string(~H"""
           <.text_input name="first_name" />
           """)
           |> format_html() ==
             """
             <input class="form-control" id="_" name="first_name" type="text" />
             """
             |> format_html()
  end

  test "Option: form_group - no header (generates a form group element with label)" do
    assigns = []

    assert rendered_to_string(~H"""
           <.text_input form={:f} field={:first_name} form_group />
           """)
           |> format_html() ==
             """
             <div class="form-group">
             <div class="form-group-header"><label for="f_first_name">First name</label></div>
             <div class="form-group-body"><input class="form-control" id="f_first_name" name="f[first_name]" type="text" /></div>
             </div>
             """
             |> format_html()
  end

  test "Option: form_group - pass header and class" do
    assigns = []

    assert rendered_to_string(~H"""
           <.text_input form={:f} field={:first_name} form_group={%{header: "First name", class: "x"}} />
           """)
           |> format_html() ==
             """
             <div class="form-group x">
             <div class="form-group-header"><label for="f_first_name">First name</label></div>
             <div class="form-group-body"><input class="form-control" id="f_first_name" name="f[first_name]" type="text" /></div>
             </div>
             """
             |> format_html()
  end

  test "Option: form_group - classes" do
    assigns = []

    assert rendered_to_string(~H"""
           <.text_input
             form={:f}
             field={:first_name}
             form_group={
               %{
                 header: "First name",
                 classes: %{
                   form_group: "form_group-x",
                   header: "header-x",
                   body: "body-x"
                 }
               }
             }
           />
           """)
           |> format_html() ==
             """
             <div class="form-group form_group-x">
             <div class="form-group-header header-x"><label for="f_first_name">First name</label></div>
             <div class="form-group-body body-x"><input class="form-control" id="f_first_name" name="f[first_name]" type="text" />
             </div>
             </div>
             """
             |> format_html()
  end

  test "Option: form_group - extra" do
    assigns = []

    assert rendered_to_string(~H"""
           <.text_input
             form={:f}
             field={:first_name}
             form_group={
               %{
                 dir: "rtl"
               }
             }
           />
           """)
           |> format_html() ==
             """
             <div class="form-group" dir="rtl">
             <div class="form-group-header"><label for="f_first_name">First name</label></div>
             <div class="form-group-body"><input class="form-control" id="f_first_name" name="f[first_name]" type="text" /></div>
             </div>
             """
             |> format_html()
  end
end
