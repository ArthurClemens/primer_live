defmodule PrimerLive.Components.DropdownMenuTest do
  use ExUnit.Case
  use PrimerLive
  import PrimerLive.Helpers.TestHelpers

  import Phoenix.LiveView.Helpers
  import Phoenix.LiveViewTest

  test "Called without options or inner_block: should render an error message" do
    assigns = []

    assert rendered_to_string(~H"""
           <.dropdown_menu />
           """)
           |> format_html() ==
             """
             <div class="flash flash-error"><p>dropdown_menu component received invalid options:</p><p>inner_block: can&#39;t be blank</p></div>
             """
             |> format_html()
  end

  test "Called without options: should render the dropdown menu element" do
    assigns = []

    assert rendered_to_string(~H"""
           <.dropdown_menu>Content</.dropdown_menu>
           """)
           |> format_html() ==
             """
             <ul class="dropdown-menu dropdown-menu-se">Content</ul>
             """
             |> format_html()
  end

  test "Option: position" do
    assigns = []

    assert rendered_to_string(~H"""
           <.dropdown_menu position="se">Content</.dropdown_menu>
           <.dropdown_menu position="ne">Content</.dropdown_menu>
           <.dropdown_menu position="e">Content</.dropdown_menu>
           <.dropdown_menu position="sw">Content</.dropdown_menu>
           <.dropdown_menu position="s">Content</.dropdown_menu>
           <.dropdown_menu position="w">Content</.dropdown_menu>
           """)
           |> format_html() ==
             """
             <ul class="dropdown-menu dropdown-menu-se">Content</ul>
             <ul class="dropdown-menu dropdown-menu-ne">Content</ul>
             <ul class="dropdown-menu dropdown-menu-e">Content</ul>
             <ul class="dropdown-menu dropdown-menu-sw">Content</ul>
             <ul class="dropdown-menu dropdown-menu-s">Content</ul>
             <ul class="dropdown-menu dropdown-menu-w">Content</ul>
             """
             |> format_html()
  end

  test "Option: position (invalid)" do
    assigns = []

    assert rendered_to_string(~H"""
           <.dropdown_menu position="x">Content</.dropdown_menu>
           """)
           |> format_html() ==
             """
             <div class="flash flash-error"><p>dropdown_menu component received invalid options:</p><p>position: is invalid</p></div>
             """
             |> format_html()
  end

  test "Slot: header" do
    assigns = []

    assert rendered_to_string(~H"""
           <.dropdown_menu>
             Content
             <:header>Header</:header>
           </.dropdown_menu>
           """)
           |> format_html() ==
             """
             <ul class="dropdown-menu dropdown-menu-se"><div class="dropdown-header">Header</div> Content</ul>
             """
             |> format_html()
  end

  test "Option: class" do
    assigns = []

    assert rendered_to_string(~H"""
           <.dropdown_menu class="x">Content</.dropdown_menu>
           """)
           |> format_html() ==
             """
             <ul class="dropdown-menu dropdown-menu-se x">Content</ul>
             """
             |> format_html()
  end

  test "Option: classes" do
    assigns = []

    assert rendered_to_string(~H"""
           <.dropdown_menu classes={
             %{
               menu: "menu-x",
               header: "header-x"
             }
           }>
             Content
             <:header>Header</:header>
           </.dropdown_menu>
           """)
           |> format_html() ==
             """
             <ul class="dropdown-menu dropdown-menu-se menu-x"><div class="dropdown-header header-x">Header</div> Content</ul>
             """
             |> format_html()
  end

  test "Extra attributes" do
    assigns = []

    assert rendered_to_string(~H"""
           <.dropdown_menu dir="rtl">Content</.dropdown_menu>
           """)
           |> format_html() ==
             """
             <ul class="dropdown-menu dropdown-menu-se" dir="rtl">Content</ul>
             """
             |> format_html()
  end
end
