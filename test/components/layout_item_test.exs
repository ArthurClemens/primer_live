defmodule PrimerLive.Components.LayoutItemTest do
  use ExUnit.Case
  use PrimerLive
  import PrimerLive.Helpers.TestHelpers

  import Phoenix.Component
  import Phoenix.LiveViewTest

  test "Called without conttent slot: should render the layout item element" do
    assigns = []

    assert rendered_to_string(~H"""
           <.layout_item />
           """)
           |> format_html() ==
             """
             <div class="flash flash-error"><p>layout_item component received invalid options:</p><p>inner_block: can&#39;t be empty</p></div>
             """
             |> format_html()
  end

  test "Called with content slot: should render the layout item element" do
    assigns = []

    assert rendered_to_string(~H"""
           <.layout_item>Content</.layout_item>
           """)
           |> format_html() ==
             """
             <div>Content</div>
             """
             |> format_html()
  end

  test "Option: main" do
    assigns = []

    assert rendered_to_string(~H"""
           <.layout_item main>Content</.layout_item>
           """)
           |> format_html() ==
             """
             <div class="Layout-main">Content</div>
             """
             |> format_html()
  end

  test "Option: main without content" do
    assigns = []

    assert rendered_to_string(~H"""
           <.layout_item main />
           """)
           |> format_html() ==
             """
             <div class="flash flash-error"><p>layout_item component received invalid options:</p><p>inner_block: can&#39;t be empty</p></div>
             """
             |> format_html()
  end

  test "Option: sidebar" do
    assigns = []

    assert rendered_to_string(~H"""
           <.layout_item sidebar>Content</.layout_item>
           """)
           |> format_html() ==
             """
             <div class="Layout-sidebar">Content</div>
             """
             |> format_html()
  end

  test "Option: divider without content" do
    assigns = []

    assert rendered_to_string(~H"""
           <.layout_item divider />
           """)
           |> format_html() ==
             """
             <div class="Layout-divider"></div>
             """
             |> format_html()
  end

  test "Option: divider with content" do
    assigns = []

    assert rendered_to_string(~H"""
           <.layout_item divider>Content</.layout_item>
           """)
           |> format_html() ==
             """
             <div class="Layout-divider">Content</div>
             """
             |> format_html()
  end

  test "Option: is_centered_md without attr main (should show an error)" do
    assigns = []

    assert rendered_to_string(~H"""
           <.layout_item is_centered_md>Content</.layout_item>
           """)
           |> format_html() ==
             """
             <div class="flash flash-error"><p>layout_item component received invalid options:</p><p>is_centered_md: must be used with &quot;main&quot;</p></div>
             """
             |> format_html()
  end

  test "Option: is_centered_md" do
    assigns = []

    assert rendered_to_string(~H"""
           <.layout_item main is_centered_md>Content</.layout_item>
           """)
           |> format_html() ==
             """
             <div class="Layout-main"><div class="Layout-main-centered-md">Content</div></div>
             """
             |> format_html()
  end

  test "Option: is_centered_lg" do
    assigns = []

    assert rendered_to_string(~H"""
           <.layout_item main is_centered_lg>Content</.layout_item>
           """)
           |> format_html() ==
             """
             <div class="Layout-main"><div class="Layout-main-centered-lg">Content</div></div>
             """
             |> format_html()
  end

  test "Option: is_centered_xl" do
    assigns = []

    assert rendered_to_string(~H"""
           <.layout_item main is_centered_xl>Content</.layout_item>
           """)
           |> format_html() ==
             """
             <div class="Layout-main"><div class="Layout-main-centered-xl">Content</div></div>
             """
             |> format_html()
  end

  test "Option: is_flow_row_shallow with main (should show an error)" do
    assigns = []

    assert rendered_to_string(~H"""
           <.layout_item main is_flow_row_shallow>Content</.layout_item>
           """)
           |> format_html() ==
             """
             <div class="flash flash-error"><p>layout_item component received invalid options:</p><p>is_flow_row_shallow: must be used with &quot;divider&quot;</p></div>
             """
             |> format_html()
  end

  test "Option: is_flow_row_shallow" do
    assigns = []

    assert rendered_to_string(~H"""
           <.layout_item divider is_flow_row_shallow />
           """)
           |> format_html() ==
             """
             <div class="Layout-divider Layout-divider--flowRow-shallow"></div>
             """
             |> format_html()
  end

  test "Option: is_flow_row_hidden" do
    assigns = []

    assert rendered_to_string(~H"""
           <.layout_item divider is_flow_row_hidden />
           """)
           |> format_html() ==
             """
             <div class="Layout-divider Layout-divider--flowRow-hidden"></div>
             """
             |> format_html()
  end

  test "Option: class" do
    assigns = []

    assert rendered_to_string(~H"""
           <.layout_item class="x">Content</.layout_item>
           """)
           |> format_html() ==
             """
             <div class="x">Content</div>
             """
             |> format_html()
  end

  test "Extra attributes" do
    assigns = []

    assert rendered_to_string(~H"""
           <.layout_item dir="rtl">Content</.layout_item>
           """)
           |> format_html() ==
             """
             <div dir="rtl">Content</div>
             """
             |> format_html()
  end
end
