defmodule PrimerLive.TestComponents.AnimatedEllipsisTest do
  use ExUnit.Case
  use PrimerLive
  import PrimerLive.Helpers.TestHelpers

  import Phoenix.Component
  import Phoenix.LiveViewTest

  test "Render component" do
    assigns = []

    assert rendered_to_string(~H"""
           <.animated_ellipsis />
           """)
           |> format_html() ==
             """
             <span class="AnimatedEllipsis"></span>
             """
             |> format_html()
  end

  test "Other attributes" do
    assigns = []

    assert rendered_to_string(~H"""
           <.animated_ellipsis class="x" dir="rtl" />
           """)
           |> format_html() ==
             """
             <span class="AnimatedEllipsis x" dir="rtl"></span>
             """
             |> format_html()
  end
end
