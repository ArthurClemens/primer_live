defmodule PrimerLive.Components.BoxRowTest do
  use ExUnit.Case
  use PrimerLive
  import PrimerLive.Helpers.TestHelpers

  import Phoenix.LiveView.Helpers
  import Phoenix.LiveViewTest

  test "Called without options or inner_block: should render an error message" do
    assigns = []

    assert rendered_to_string(~H"""
           <.box_slot row />
           """)
           |> format_html() ==
             """
             <div class="flash flash-error"><p>box_slot component received invalid options:</p><p>inner_block: can&#39;t be blank</p></div>
             """
             |> format_html()
  end

  test "Called without options: should render the box element" do
    assigns = []

    assert rendered_to_string(~H"""
           <.box_slot row>
             Content
           </.box_slot>
           """)
           |> format_html() ==
             """
             <div class="Box-row">Content</div>
             """
             |> format_html()
  end

  test "Option: is_blue" do
    assigns = []

    assert rendered_to_string(~H"""
           <.box_slot row is_blue>Content</.box_slot>
           """)
           |> format_html() ==
             """
             <div class="Box-row Box-row--blue">Content</div>
             """
             |> format_html()
  end

  test "Option: is_yellow" do
    assigns = []

    assert rendered_to_string(~H"""
           <.box_slot row is_yellow>Content</.box_slot>
           """)
           |> format_html() ==
             """
             <div class="Box-row Box-row--yellow">Content</div>
             """
             |> format_html()
  end

  test "Option: is_gray" do
    assigns = []

    assert rendered_to_string(~H"""
           <.box_slot row is_gray>Content</.box_slot>
           """)
           |> format_html() ==
             """
             <div class="Box-row Box-row--gray">Content</div>
             """
             |> format_html()
  end

  test "Option: is_focus_blue" do
    assigns = []

    assert rendered_to_string(~H"""
           <.box_slot row is_focus_blue>Content</.box_slot>
           """)
           |> format_html() ==
             """
             <div class="Box-row Box-row--focus-blue">Content</div>
             """
             |> format_html()
  end

  test "Option: is_focus_gray" do
    assigns = []

    assert rendered_to_string(~H"""
           <.box_slot row is_focus_gray>Content</.box_slot>
           """)
           |> format_html() ==
             """
             <div class="Box-row Box-row--focus-gray">Content</div>
             """
             |> format_html()
  end

  test "Option: is_hover_blue" do
    assigns = []

    assert rendered_to_string(~H"""
           <.box_slot row is_hover_blue>Content</.box_slot>
           """)
           |> format_html() ==
             """
             <div class="Box-row Box-row--hover-blue">Content</div>
             """
             |> format_html()
  end

  test "Option: is_hover_gray" do
    assigns = []

    assert rendered_to_string(~H"""
           <.box_slot row is_hover_gray>Content</.box_slot>
           """)
           |> format_html() ==
             """
             <div class="Box-row Box-row--hover-gray">Content</div>
             """
             |> format_html()
  end

  test "Option: is_navigation_focus" do
    assigns = []

    assert rendered_to_string(~H"""
           <.box_slot row is_navigation_focus>Content</.box_slot>
           """)
           |> format_html() ==
             """
             <div class="Box-row navigation-focus">Content</div>
             """
             |> format_html()
  end

  test "Option: is_unread" do
    assigns = []

    assert rendered_to_string(~H"""
           <.box_slot row is_unread>Content</.box_slot>
           """)
           |> format_html() ==
             """
             <div class="Box-row Box-row--unread">Content</div>
             """
             |> format_html()
  end

  test "Option: class" do
    assigns = []

    assert rendered_to_string(~H"""
           <.box_slot row class="x">Content</.box_slot>
           """)
           |> format_html() ==
             """
             <div class="Box-row x">Content</div>
             """
             |> format_html()
  end

  test "Extra attributes" do
    assigns = []

    assert rendered_to_string(~H"""
           <.box_slot row dir="rtl">Content</.box_slot>
           """)
           |> format_html() ==
             """
             <div class="Box-row" dir="rtl">Content</div>
             """
             |> format_html()
  end
end
