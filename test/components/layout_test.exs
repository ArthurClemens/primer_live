defmodule PrimerLive.Components.LayoutTest do
  use ExUnit.Case
  use PrimerLive
  import PrimerLive.Helpers.TestHelpers

  import Phoenix.Component
  import Phoenix.LiveViewTest

  defp test_layout_attr(assigns) do
    ~H"""
    <.layout {assigns}>
      <.layout_item main>
        Main content
      </.layout_item>
      <.layout_item divider />
      <.layout_item sidebar>
        Sidebar content
      </.layout_item>
    </.layout>
    """
  end

  test "Called without content slot: should show an error" do
    assigns = []

    assert rendered_to_string(~H"""
           <.layout />
           """)
           |> format_html() ==
             """
             <div class=\"flash flash-error\"><p>layout component received invalid options:</p><p>inner_block: can&#39;t be blank</p></div>
             """
             |> format_html()
  end

  test "Called with empty content slot: should render the layout element" do
    assigns = []

    assert rendered_to_string(~H"""
           <.layout></.layout>
           """)
           |> format_html() ==
             """
             <div class="Layout"></div>
             """
             |> format_html()
  end

  test "Called with content slot: should render the layout element" do
    assigns = []

    assert rendered_to_string(~H"""
           <.layout>
             <.layout_item main>
               Main content
             </.layout_item>
             <.layout_item sidebar>
               Sidebar content
             </.layout_item>
           </.layout>
           """)
           |> format_html() ==
             """
             <div class="Layout">
             <div class="Layout-main">Main content</div>
             <div class="Layout-sidebar">Sidebar content</div>
             </div>
             """
             |> format_html()
  end

  test "Called with items in specific order: should maintain order" do
    assigns = []

    assert rendered_to_string(~H"""
           <.layout>
             <.layout_item sidebar>
               Sidebar content
             </.layout_item>
             <.layout_item divider />
             <.layout_item main>
               Main content
             </.layout_item>
           </.layout>
           """)
           |> format_html() ==
             """
             <div class="Layout">
             <div class="Layout-sidebar">Sidebar content</div>
             <div class="Layout-divider"></div>
             <div class="Layout-main">Main content</div>
             </div>
             """
             |> format_html()
  end

  test "Option: is_narrow_sidebar" do
    assigns = []

    assert rendered_to_string(~H"""
           <.test_layout_attr is_narrow_sidebar />
           """)
           |> format_html() ==
             """
             <div class="Layout Layout--sidebar-narrow">
             <div class="Layout-main">Main content</div>
             <div class="Layout-divider"></div>
             <div class="Layout-sidebar">Sidebar content</div>
             </div>
             """
             |> format_html()
  end

  test "Option: is_wide_sidebar" do
    assigns = []

    assert rendered_to_string(~H"""
           <.test_layout_attr is_wide_sidebar />
           """)
           |> format_html() ==
             """
             <div class="Layout Layout--sidebar-wide">
             <div class="Layout-main">Main content</div>
             <div class="Layout-divider"></div>
             <div class="Layout-sidebar">Sidebar content</div>
             </div>
             """
             |> format_html()
  end

  test "Option: is_divided" do
    assigns = []

    assert rendered_to_string(~H"""
           <.test_layout_attr is_divided />
           """)
           |> format_html() ==
             """
             <div class="Layout Layout--divided">
             <div class="Layout-main">Main content</div>
             <div class="Layout-divider"></div>
             <div class="Layout-sidebar">Sidebar content</div>
             </div>
             """
             |> format_html()
  end

  test "Option: is_gutter_none" do
    assigns = []

    assert rendered_to_string(~H"""
           <.test_layout_attr is_gutter_none />
           """)
           |> format_html() ==
             """
             <div class="Layout Layout--gutter-none">
             <div class="Layout-main">Main content</div>
             <div class="Layout-divider"></div>
             <div class="Layout-sidebar">Sidebar content</div>
             </div>
             """
             |> format_html()
  end

  test "Option: is_gutter_condensed" do
    assigns = []

    assert rendered_to_string(~H"""
           <.test_layout_attr is_gutter_condensed />
           """)
           |> format_html() ==
             """
             <div class="Layout Layout--gutter-condensed">
             <div class="Layout-main">Main content</div>
             <div class="Layout-divider"></div>
             <div class="Layout-sidebar">Sidebar content</div>
             </div>
             """
             |> format_html()
  end

  test "Option: is_gutter_spacious" do
    assigns = []

    assert rendered_to_string(~H"""
           <.test_layout_attr is_gutter_spacious />
           """)
           |> format_html() ==
             """
             <div class="Layout Layout--gutter-spacious">
             <div class="Layout-main">Main content</div>
             <div class="Layout-divider"></div>
             <div class="Layout-sidebar">Sidebar content</div>
             </div>
             """
             |> format_html()
  end

  test "Option: is_sidebar_position_start" do
    assigns = []

    assert rendered_to_string(~H"""
           <.test_layout_attr is_sidebar_position_start />
           """)
           |> format_html() ==
             """
             <div class="Layout Layout--sidebarPosition-start">
             <div class="Layout-main">Main content</div>
             <div class="Layout-divider"></div>
             <div class="Layout-sidebar">Sidebar content</div>
             </div>
             """
             |> format_html()
  end

  test "Option: is_sidebar_position_end" do
    assigns = []

    assert rendered_to_string(~H"""
           <.test_layout_attr is_sidebar_position_end />
           """)
           |> format_html() ==
             """
             <div class="Layout Layout--sidebarPosition-end">
             <div class="Layout-main">Main content</div>
             <div class="Layout-divider"></div>
             <div class="Layout-sidebar">Sidebar content</div>
             </div>
             """
             |> format_html()
  end

  test "Option: is_sidebar_position_flow_row_start" do
    assigns = []

    assert rendered_to_string(~H"""
           <.test_layout_attr is_sidebar_position_flow_row_start />
           """)
           |> format_html() ==
             """
             <div class="Layout Layout--sidebarPosition-flowRow-start">
             <div class="Layout-main">Main content</div>
             <div class="Layout-divider"></div>
             <div class="Layout-sidebar">Sidebar content</div>
             </div>
             """
             |> format_html()
  end

  test "Option: is_sidebar_position_flow_row_end" do
    assigns = []

    assert rendered_to_string(~H"""
           <.test_layout_attr is_sidebar_position_flow_row_end />
           """)
           |> format_html() ==
             """
             <div class="Layout Layout--sidebarPosition-flowRow-end">
             <div class="Layout-main">Main content</div>
             <div class="Layout-divider"></div>
             <div class="Layout-sidebar">Sidebar content</div>
             </div>
             """
             |> format_html()
  end

  test "Option: is_sidebar_position_flow_row_none" do
    assigns = []

    assert rendered_to_string(~H"""
           <.test_layout_attr is_sidebar_position_flow_row_none />
           """)
           |> format_html() ==
             """
             <div class="Layout Layout--sidebarPosition-flowRow-none">
             <div class="Layout-main">Main content</div>
             <div class="Layout-divider"></div>
             <div class="Layout-sidebar">Sidebar content</div>
             </div>
             """
             |> format_html()
  end

  test "Option: is_flow_row_until_md" do
    assigns = []

    assert rendered_to_string(~H"""
           <.test_layout_attr is_flow_row_until_md />
           """)
           |> format_html() ==
             """
             <div class="Layout Layout--flowRow-until-md">
             <div class="Layout-main">Main content</div>
             <div class="Layout-divider"></div>
             <div class="Layout-sidebar">Sidebar content</div>
             </div>
             """
             |> format_html()
  end

  test "Option: is_flow_row_until_lg" do
    assigns = []

    assert rendered_to_string(~H"""
           <.test_layout_attr is_flow_row_until_lg />
           """)
           |> format_html() ==
             """
             <div class="Layout Layout--flowRow-until-lg">
             <div class="Layout-main">Main content</div>
             <div class="Layout-divider"></div>
             <div class="Layout-sidebar">Sidebar content</div>
             </div>
             """
             |> format_html()
  end

  test "Option: class" do
    assigns = []

    assert rendered_to_string(~H"""
           <.test_layout_attr class="x" />
           """)
           |> format_html() ==
             """
             <div class="Layout x">
             <div class="Layout-main">Main content</div>
             <div class="Layout-divider"></div>
             <div class="Layout-sidebar">Sidebar content</div>
             </div>
             """
             |> format_html()
  end

  test "Extra attributes" do
    assigns = []

    assert rendered_to_string(~H"""
           <.test_layout_attr dir="rtl" />
           """)
           |> format_html() ==
             """
             <div class="Layout" dir="rtl">
             <div class="Layout-main">Main content</div>
             <div class="Layout-divider"></div>
             <div class="Layout-sidebar">Sidebar content</div>
             </div>
             """
             |> format_html()
  end
end
