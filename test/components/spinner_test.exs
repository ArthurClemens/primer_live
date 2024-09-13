defmodule PrimerLive.Components.SpinnerTest do
  use ExUnit.Case
  use PrimerLive
  import PrimerLive.Helpers.TestHelpers

  import Phoenix.Component
  import Phoenix.LiveViewTest

  test "Render component" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.spinner />
           """)
           |> format_html() ==
             """
             <svg viewBox="0 0 16 16" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" focusable="false" fill="none"
             class="anim-rotate" height="32" width="32">STRIPPED_SVG_PATHS</svg>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end

  test "Attribute: size" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.spinner size="40" />
           <.spinner size={40} />
           """)
           |> format_html() ==
             """
             <svg viewBox="0 0 16 16" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" focusable="false" fill="none"
             class="anim-rotate" height="40" width="40">STRIPPED_SVG_PATHS</svg><svg viewBox="0 0 16 16"
             xmlns="http://www.w3.org/2000/svg" aria-hidden="true" focusable="false" fill="none" class="anim-rotate" height="40"
             width="40">STRIPPED_SVG_PATHS</svg>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end

  test "Attribute: color" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.spinner color="red" />
           <.spinner color="#ff0000" />
           <.spinner color="rgba(250, 50, 150, 0.5)" />
           """)
           |> format_html() ==
             """
             <svg viewBox="0 0 16 16" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" focusable="false" fill="none"
             class="anim-rotate" height="32" width="32">STRIPPED_SVG_PATHS</svg><svg viewBox="0 0 16 16"
             xmlns="http://www.w3.org/2000/svg" aria-hidden="true" focusable="false" fill="none" class="anim-rotate" height="32"
             width="32">STRIPPED_SVG_PATHS</svg><svg viewBox="0 0 16 16" xmlns="http://www.w3.org/2000/svg" aria-hidden="true"
             focusable="false" fill="none" class="anim-rotate" height="32" width="32">STRIPPED_SVG_PATHS</svg>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end

  test "Attribute: highlight_color" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.spinner highlight_color="black" />
           <.spinner highlight_color="#000000" />
           <.spinner highlight_color="rgba(0, 0, 0, 1)" />
           """)
           |> format_html() ==
             """
             <svg viewBox="0 0 16 16" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" focusable="false" fill="none"
             class="anim-rotate" height="32" width="32">STRIPPED_SVG_PATHS</svg><svg viewBox="0 0 16 16"
             xmlns="http://www.w3.org/2000/svg" aria-hidden="true" focusable="false" fill="none" class="anim-rotate" height="32"
             width="32">STRIPPED_SVG_PATHS</svg><svg viewBox="0 0 16 16" xmlns="http://www.w3.org/2000/svg" aria-hidden="true"
             focusable="false" fill="none" class="anim-rotate" height="32" width="32">STRIPPED_SVG_PATHS</svg>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end

  test "Attribute: gap_color (deprecated)" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.spinner gap_color="black" />
           <.spinner gap_color="#000000" />
           <.spinner gap_color="rgba(0, 0, 0, 1)" />
           """)
           |> format_html() ==
             """
             <svg viewBox="0 0 16 16" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" focusable="false" fill="none"
             class="anim-rotate" height="32" width="32">STRIPPED_SVG_PATHS</svg><svg viewBox="0 0 16 16"
             xmlns="http://www.w3.org/2000/svg" aria-hidden="true" focusable="false" fill="none" class="anim-rotate" height="32"
             width="32">STRIPPED_SVG_PATHS</svg><svg viewBox="0 0 16 16" xmlns="http://www.w3.org/2000/svg" aria-hidden="true"
             focusable="false" fill="none" class="anim-rotate" height="32" width="32">STRIPPED_SVG_PATHS</svg>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end

  test "Other attributes" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.spinner class="my-spinner" dir="rtl" />
           """)
           |> format_html() ==
             """
             <svg viewBox="0 0 16 16" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" focusable="false" fill="none"
             class="anim-rotate my-spinner" dir="rtl" height="32" width="32" dir="rtl">STRIPPED_SVG_PATHS</svg>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end
end
