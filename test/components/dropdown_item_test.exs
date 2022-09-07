defmodule PrimerLive.Components.DropdownItemTest do
  use ExUnit.Case
  use PrimerLive
  import PrimerLive.Helpers.TestHelpers

  import Phoenix.LiveView.Helpers
  import Phoenix.LiveViewTest

  test "Called without options or inner_block: should render an error message" do
    assigns = []

    assert rendered_to_string(~H"""
           <.dropdown_item />
           """)
           |> format_html() ==
             """
             <div class="flash flash-error"><p>dropdown_item component received invalid options:</p><p>inner_block: can&#39;t be blank</p></div>
             """
             |> format_html()
  end

  test "Called without options: should render the dropdown item element" do
    assigns = []

    assert rendered_to_string(~H"""
           <.dropdown_item>Content</.dropdown_item>
           """)
           |> format_html() ==
             """
             <li class="dropdown-item">Content</li>
             """
             |> format_html()
  end

  test "Option: is_divider" do
    assigns = []

    assert rendered_to_string(~H"""
           <.dropdown_item is_divider />
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
           <.dropdown_item is_divider>Content</.dropdown_item>
           """)
           |> format_html() ==
             """
             <li class="dropdown-divider" role="separator"></li>
             """
             |> format_html()
  end

  test "Option: class" do
    assigns = []

    assert rendered_to_string(~H"""
           <.dropdown_item class="x">Item</.dropdown_item>
           """)
           |> format_html() ==
             """
             <li class="dropdown-item x">Item</li>
             """
             |> format_html()
  end

  test "Extra attributes" do
    assigns = []

    assert rendered_to_string(~H"""
           <.dropdown_item href="#">Item</.dropdown_item>
           """)
           |> format_html() ==
             """
             <li href="#" class="dropdown-item">Item</li>
             """
             |> format_html()
  end
end
