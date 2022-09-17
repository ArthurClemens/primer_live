defmodule PrimerLive.Components.FormTestareaTest do
  use ExUnit.Case
  use PrimerLive
  import PrimerLive.Helpers.TestHelpers

  import Phoenix.Component
  import Phoenix.LiveViewTest

  test "Called without options: should render the component" do
    assigns = []

    assert rendered_to_string(~H"""
           <.textarea />
           """)
           |> format_html() ==
             """
             <textarea class="form-control" id="_" name="[]"></textarea>
             """
             |> format_html()
  end

  test "Option: is_large" do
    assigns = []

    assert rendered_to_string(~H"""
           <.textarea is_large />
           """)
           |> format_html() ==
             """
             <textarea class="form-control input-lg" id="_" name="[]"></textarea>
             """
             |> format_html()
  end

  test "Option: is_small" do
    assigns = []

    assert rendered_to_string(~H"""
           <.textarea is_small />
           """)
           |> format_html() ==
             """
             <textarea class="form-control input-sm" id="_" name="[]"></textarea>
             """
             |> format_html()
  end

  test "Option: is_short without form_group: should render an error message" do
    assigns = []

    assert rendered_to_string(~H"""
           <.textarea is_short />
           """)
           |> format_html() ==
             """
             <div class="flash flash-error"><p>textarea component received invalid options:</p><p>is_short: must be used with form_group</p></div>
             """
             |> format_html()
  end

  test "Option: is_short with form_group" do
    assigns = []

    assert rendered_to_string(~H"""
           <.textarea form={:f} field={:first_name} is_short form_group />
           """)
           |> format_html() ==
             """
             <div class="form-group"><div class="form-group-header"><label for="f_first_name">First name</label></div>
             <div class="form-group-body"><textarea class="form-control short" id="f_first_name" name="f[first_name]"></textarea>
             </div>
             </div>
             """
             |> format_html()
  end

  test "Option: class" do
    assigns = []

    assert rendered_to_string(~H"""
           <.textarea class="x" />
           """)
           |> format_html() ==
             """
             <textarea class="form-control x" id="_" name="[]"></textarea>
             """
             |> format_html()
  end
end
