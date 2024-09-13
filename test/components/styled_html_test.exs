defmodule PrimerLive.TestComponents.StyledHtmlTest do
  use ExUnit.Case
  use PrimerLive
  import PrimerLive.Helpers.TestHelpers

  import Phoenix.Component
  import Phoenix.LiveViewTest

  test "Render content" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.styled_html>
             Content
           </.styled_html>
           """)
           |> format_html() ==
             """
             <div class="markdown-body">Content</div>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end

  test "Attribute: class" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.styled_html class="my-content">
             Content
           </.styled_html>
           """)
           |> format_html() ==
             """
             <div class="markdown-body my-content">Content</div>
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
           <.styled_html dir="rtl">
             Content
           </.styled_html>
           """)
           |> format_html() ==
             """
             <div class="markdown-body" dir="rtl">Content</div>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end
end
