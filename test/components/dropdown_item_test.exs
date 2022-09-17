defmodule PrimerLive.Components.DropdownItemTest do
  use ExUnit.Case
  use PrimerLive
  import PrimerLive.Helpers.TestHelpers

  import Phoenix.Component
  import Phoenix.LiveViewTest

  defp render_caret(assigns) do
    ~H"""
    <div class="my-dropdown-caret"></div>
    """
  end

  test "Called without options or inner_block: should render an error message" do
    assigns = []

    assert rendered_to_string(~H"""
           <.dropdown_item />
           """)
           |> format_html() ==
             """
             <div class="flash flash-error"><p>dropdown_item component received invalid options:</p><p>dropdown_item: must contain one attribute from these options: toggle, menu, option, divider</p><p>inner_block: can&#39;t be blank</p></div>
             """
             |> format_html()
  end

  test "Called without options: should show an error" do
    assigns = []

    assert rendered_to_string(~H"""
           <.dropdown_item>Content</.dropdown_item>
           """)
           |> format_html() ==
             """
             <div class="flash flash-error"><p>dropdown_item component received invalid options:</p><p>dropdown_item: must contain one attribute from these options: toggle, menu, option, divider</p></div>
             """
             |> format_html()
  end

  test "Option: menu" do
    assigns = []

    assert rendered_to_string(~H"""
           <.dropdown_item menu>Content</.dropdown_item>
           """)
           |> format_html() ==
             """
             <ul class="dropdown-menu dropdown-menu-se">Content</ul>
             """
             |> format_html()
  end

  test "Option: toggle" do
    assigns = []

    assert rendered_to_string(~H"""
           <.dropdown_item toggle>Content</.dropdown_item>
           """)
           |> format_html() ==
             """
             <summary class="btn" aria-haspopup="true">Content<div class="dropdown-caret"></div></summary>
             """
             |> format_html()
  end

  test "Option: toggle with custom caret" do
    assigns = []

    assert rendered_to_string(~H"""
           <.dropdown_item toggle render_caret={&render_caret/1}>Content</.dropdown_item>
           """)
           |> format_html() ==
             """
             <summary class="btn" aria-haspopup="true">Content<div class="my-dropdown-caret"></div></summary>
             """
             |> format_html()
  end

  test "Option: menu with custom caret (should shown an error)" do
    assigns = []

    assert rendered_to_string(~H"""
           <.dropdown_item menu render_caret={&render_caret/1}>Content</.dropdown_item>
           """)
           |> format_html() ==
             """
             <div class="flash flash-error"><p>dropdown_item component received invalid options:</p><p>render_caret: must be used with &quot;toggle&quot;</p></div>
             """
             |> format_html()
  end

  test "Option: toggle with header_title - should show an error" do
    assigns = []

    assert rendered_to_string(~H"""
           <.dropdown_item toggle header_title="Header">Content</.dropdown_item>
           """)
           |> format_html() ==
             """
             <div class="flash flash-error"><p>dropdown_item component received invalid options:</p><p>header_title: must be used with &quot;menu&quot;</p></div>
             """
             |> format_html()
  end

  test "Option: menu with header_title" do
    assigns = []

    assert rendered_to_string(~H"""
           <.dropdown_item menu header_title="Header">Content</.dropdown_item>
           """)
           |> format_html() ==
             """
             <div class="dropdown-menu dropdown-menu-se">
             <div class="dropdown-header">Header</div>
             <ul>Content</ul>
             </div>
             """
             |> format_html()
  end

  test "Option: menu with position" do
    assigns = []

    assert rendered_to_string(~H"""
           <.dropdown_item menu position="se">Content</.dropdown_item>
           <.dropdown_item menu position="ne">Content</.dropdown_item>
           <.dropdown_item menu position="e">Content</.dropdown_item>
           <.dropdown_item menu position="sw">Content</.dropdown_item>
           <.dropdown_item menu position="s">Content</.dropdown_item>
           <.dropdown_item menu position="w">Content</.dropdown_item>
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

  test "Option: menu with position (invalid)" do
    assigns = []

    assert rendered_to_string(~H"""
           <.dropdown_item menu position="x">Content</.dropdown_item>
           """)
           |> format_html() ==
             """
             <div class="flash flash-error"><p>dropdown_item component received invalid options:</p><p>position: is invalid</p></div>
             """
             |> format_html()
  end

  test "Option: option" do
    assigns = []

    assert rendered_to_string(~H"""
           <.dropdown_item option>Content</.dropdown_item>
           """)
           |> format_html() ==
             """
             <li class="dropdown-item">Content</li>
             """
             |> format_html()
  end

  test "Option: divider" do
    assigns = []

    assert rendered_to_string(~H"""
           <.dropdown_item divider />
           """)
           |> format_html() ==
             """
             <li class="dropdown-divider" role="separator"></li>
             """
             |> format_html()
  end

  test "Option: is_divider with content (ignored)" do
    assigns = []

    assert rendered_to_string(~H"""
           <.dropdown_item divider>Content</.dropdown_item>
           """)
           |> format_html() ==
             """
             <li class="dropdown-divider" role="separator"></li>
             """
             |> format_html()
  end

  test "Option: class (option)" do
    assigns = []

    assert rendered_to_string(~H"""
           <.dropdown_item option class="x">Item</.dropdown_item>
           """)
           |> format_html() ==
             """
             <li class="dropdown-item x">Item</li>
             """
             |> format_html()
  end

  test "Option: class (toggle)" do
    assigns = []

    assert rendered_to_string(~H"""
           <.dropdown_item toggle class="x">Item</.dropdown_item>
           """)
           |> format_html() ==
             """
             <summary class="x" aria-haspopup="true">Item<div class="dropdown-caret"></div></summary>
             """
             |> format_html()
  end

  test "Option: class (menu)" do
    assigns = []

    assert rendered_to_string(~H"""
           <.dropdown_item menu class="x">Item</.dropdown_item>
           """)
           |> format_html() ==
             """
             <ul class="dropdown-menu dropdown-menu-se x">Item</ul>
             """
             |> format_html()
  end

  test "Extra attributes" do
    assigns = []

    assert rendered_to_string(~H"""
           <.dropdown_item option href="#">Item</.dropdown_item>
           """)
           |> format_html() ==
             """
             <li href="#" class="dropdown-item">Item</li>
             """
             |> format_html()
  end
end
