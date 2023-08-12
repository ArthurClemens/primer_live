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
             <svg class="Toast--spinner" height="18" viewBox="0 0 32 32" width="18">STRIPPED_SVG_PATHSSTRIPPED_SVG_PATHS</svg>
             """
             |> format_html()
  end

  test "Attribute: size" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.spinner size="40" />
           <.spinner size={40} />
           """)
           |> format_html() ==
             """
             <svg class="Toast--spinner" height="40" viewBox="0 0 32 32" width="40">STRIPPED_SVG_PATHSSTRIPPED_SVG_PATHS</svg><svg
             class="Toast--spinner" height="40" viewBox="0 0 32 32" width="40">STRIPPED_SVG_PATHSSTRIPPED_SVG_PATHS</svg>
             """
             |> format_html()
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
             <svg class="Toast--spinner" height="18" viewBox="0 0 32 32" width="18">STRIPPED_SVG_PATHSSTRIPPED_SVG_PATHS</svg><svg
             class="Toast--spinner" height="18" viewBox="0 0 32 32" width="18">STRIPPED_SVG_PATHSSTRIPPED_SVG_PATHS</svg><svg
             class="Toast--spinner" height="18" viewBox="0 0 32 32" width="18">STRIPPED_SVG_PATHSSTRIPPED_SVG_PATHS</svg>
             """
             |> format_html()
  end

  test "Attribute: gap color" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.spinner gap_color="black" />
           <.spinner gap_color="#000000" />
           <.spinner gap_color="rgba(0, 0, 0, 1)" />
           """)
           |> format_html() ==
             """
             <svg class="Toast--spinner" height="18" viewBox="0 0 32 32" width="18">STRIPPED_SVG_PATHSSTRIPPED_SVG_PATHS</svg><svg
             class="Toast--spinner" height="18" viewBox="0 0 32 32" width="18">STRIPPED_SVG_PATHSSTRIPPED_SVG_PATHS</svg><svg
             class="Toast--spinner" height="18" viewBox="0 0 32 32" width="18">STRIPPED_SVG_PATHSSTRIPPED_SVG_PATHS</svg>
             """
             |> format_html()
  end

  test "Other attributes" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.spinner class="my-spinner" dir="rtl" />
           """)
           |> format_html() ==
             """
             <svg class="Toast--spinner my-spinner" dir="rtl" height="18" viewBox="0 0 32 32"
             width="18">STRIPPED_SVG_PATHSSTRIPPED_SVG_PATHS</svg>
             """
             |> format_html()
  end
end
