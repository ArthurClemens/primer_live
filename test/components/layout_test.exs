defmodule PrimerLive.Components.LayoutTest do
  use ExUnit.Case
  use PrimerLive
  import PrimerLive.Helpers.TestHelpers

  import Phoenix.LiveView.Helpers
  import Phoenix.LiveViewTest

  defp test_layout_attr(assigns) do
    ~H"""
    <.layout {assigns}>
      <:item name="main">
        Main content
      </:item>
      <:item name="divider"></:item>
      <:item name="sidebar">
        Sidebar content
      </:item>
    </.layout>
    """
  end

  test "Called without slots: should render the layout element" do
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

  test "Called with slots: should render the layout element" do
    assigns = []

    assert rendered_to_string(~H"""
           <.layout>
             <:item name="main">
               Main content
             </:item>
             <:item name="sidebar">
               Sidebar content
             </:item>
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

  test "Called with slots in specific order: should maintain order" do
    assigns = []

    assert rendered_to_string(~H"""
           <.layout>
             <:item name="sidebar">
               Sidebar content
             </:item>
             <:item name="divider"></:item>
             <:item name="main">
               Main content
             </:item>
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

  test "Option: is_main_centered_md" do
    assigns = []

    assert rendered_to_string(~H"""
           <.test_layout_attr is_main_centered_md />
           """)
           |> format_html() ==
             """
             <div class="Layout">
             <div class="Layout-main">
             <div class="Layout-main-centered-md">Main content</div>
             </div>
             <div class="Layout-divider"></div>
             <div class="Layout-sidebar">Sidebar content</div>
             </div>
             """
             |> format_html()
  end

  test "Option: is_main_centered_lg" do
    assigns = []

    assert rendered_to_string(~H"""
           <.test_layout_attr is_main_centered_lg />
           """)
           |> format_html() ==
             """
             <div class="Layout">
             <div class="Layout-main">
             <div class="Layout-main-centered-lg">Main content</div>
             </div>
             <div class="Layout-divider"></div>
             <div class="Layout-sidebar">Sidebar content</div>
             </div>
             """
             |> format_html()
  end

  test "Option: is_main_centered_xl" do
    assigns = []

    assert rendered_to_string(~H"""
           <.test_layout_attr is_main_centered_xl />
           """)
           |> format_html() ==
             """
             <div class="Layout">
             <div class="Layout-main">
             <div class="Layout-main-centered-xl">Main content</div>
             </div>
             <div class="Layout-divider"></div>
             <div class="Layout-sidebar">Sidebar content</div>
             </div>
             """
             |> format_html()
  end

  test "Option: is_divider_flow_row_shallow" do
    assigns = []

    assert rendered_to_string(~H"""
           <.test_layout_attr is_divider_flow_row_shallow />
           """)
           |> format_html() ==
             """
             <div class="Layout">
             <div class="Layout-main">Main content</div>
             <div class="Layout-divider Layout-divider--flowRow-shallow"></div>
             <div class="Layout-sidebar">Sidebar content</div>
             </div>
             """
             |> format_html()
  end

  test "Option: is_divider_flow_row_hidden" do
    assigns = []

    assert rendered_to_string(~H"""
           <.test_layout_attr is_divider_flow_row_hidden />
           """)
           |> format_html() ==
             """
             <div class="Layout">
             <div class="Layout-main">Main content</div>
             <div class="Layout-divider Layout-divider--flowRow-hidden"></div>
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

  test "Option: classes" do
    assigns = []

    assert rendered_to_string(~H"""
           <.test_layout_attr
             is_main_centered_md
             classes={
               %{
                 layout: "layout-x",
                 main: "main-x",
                 divider: "divider-x",
                 sidebar: "sidebar-x",
                 main_center_wrapper: "main_center_wrapper-x"
               }
             }
           />
           """)
           |> format_html() ==
             """
             <div class="Layout layout-x">
             <div class="Layout-main main-x">
             <div class="main_center_wrapper-x Layout-main-centered-md">Main content</div>
             </div>
             <div class="Layout-divider divider-x"></div>
             <div class="Layout-sidebar sidebar-x">Sidebar content</div>
             </div>
             """
             |> format_html()
  end
end
