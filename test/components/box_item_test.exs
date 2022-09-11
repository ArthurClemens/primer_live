defmodule PrimerLive.Components.BoxItemTest do
  use ExUnit.Case
  use PrimerLive
  import PrimerLive.Helpers.TestHelpers

  import Phoenix.LiveView.Helpers
  import Phoenix.LiveViewTest

  test "Called without options or inner_block: should render an error message" do
    assigns = []

    assert rendered_to_string(~H"""
           <.box_item />
           """)
           |> format_html() ==
             """
             <div class="flash flash-error"><p>box_item component received invalid options:</p><p>inner_block: can&#39;t be blank</p></div>
             """
             |> format_html()
  end

  test "Called without options: should render the box element" do
    assigns = []

    assert rendered_to_string(~H"""
           <.box_item>
             Content
           </.box_item>
           """)
           |> format_html() ==
             """
             <div>Content</div>
             """
             |> format_html()
  end

  test "Option: header" do
    assigns = []

    assert rendered_to_string(~H"""
           <.box_item header>Content</.box_item>
           """)
           |> format_html() ==
             """
             <div class="Box-header">Content</div>
             """
             |> format_html()
  end

  test "Option: title" do
    assigns = []

    assert rendered_to_string(~H"""
           <.box_item title>Content</.box_item>
           """)
           |> format_html() ==
             """
             <h3 class="Box-title">Content</h3>
             """
             |> format_html()
  end

  test "Option: body" do
    assigns = []

    assert rendered_to_string(~H"""
           <.box_item body>Content</.box_item>
           """)
           |> format_html() ==
             """
             <div class="Box-body">Content</div>
             """
             |> format_html()
  end

  test "Option: row" do
    assigns = []

    assert rendered_to_string(~H"""
           <.box_item row>Content</.box_item>
           """)
           |> format_html() ==
             """
             <div class="Box-row">Content</div>
             """
             |> format_html()
  end

  test "Option: footer" do
    assigns = []

    assert rendered_to_string(~H"""
           <.box_item footer>Content</.box_item>
           """)
           |> format_html() ==
             """
             <div class="Box-footer">Content</div>
             """
             |> format_html()
  end

  test "Option: is_link" do
    assigns = []

    assert rendered_to_string(~H"""
           <.box_item row is_link href="/home">Go to Home</.box_item>
           """)
           |> format_html() ==
             """
             <div class="Box-row"><a href="/home" class="Box-row-link">Go to Home</a></div>
             """
             |> format_html()
  end

  test "Option: header with is_link (should show an error)" do
    assigns = []

    assert rendered_to_string(~H"""
           <.box_item header is_link>Go to Home</.box_item>
           """)
           |> format_html() ==
             """
             <div class="flash flash-error"><p>box_item component received invalid options:</p><p>is_link: must be used with &quot;row&quot;</p></div>
             """
             |> format_html()
  end

  test "Option: is_blue" do
    assigns = []

    assert rendered_to_string(~H"""
           <.box_item row is_blue>Content</.box_item>
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
           <.box_item row is_yellow>Content</.box_item>
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
           <.box_item row is_gray>Content</.box_item>
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
           <.box_item row is_focus_blue>Content</.box_item>
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
           <.box_item row is_focus_gray>Content</.box_item>
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
           <.box_item row is_hover_blue>Content</.box_item>
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
           <.box_item row is_hover_gray>Content</.box_item>
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
           <.box_item row is_navigation_focus>Content</.box_item>
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
           <.box_item row is_unread>Content</.box_item>
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
           <.box_item row class="x">Content</.box_item>
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
           <.box_item row dir="rtl">Content</.box_item>
           """)
           |> format_html() ==
             """
             <div dir="rtl" class="Box-row">Content</div>
             """
             |> format_html()
  end
end
