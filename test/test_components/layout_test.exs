defmodule PrimerLive.TestComponents.LayoutTest do
  use ExUnit.Case
  use PrimerLive
  import PrimerLive.Helpers.TestHelpers

  import Phoenix.Component
  import Phoenix.LiveViewTest

  defp test_layout_with_slots(assigns) do
    ~H"""
    <.test_layout {assigns}>
      <:main>
        Main content
      </:main>
      <:divider></:divider>
      <:sidebar>
        Sidebar content
      </:sidebar>
    </.test_layout>
    """
  end

  test "Without attributes or slots" do
    assigns = []

    assert rendered_to_string(~H"""
           <.test_layout></.test_layout>
           """)
           |> format_html() ==
             """
             <div class="Layout"></div>
             """
             |> format_html()
  end

  test "Slots" do
    assigns = []

    assert rendered_to_string(~H"""
           <.test_layout>
             <:main>
               Main content
             </:main>
             <:sidebar>
               Sidebar content
             </:sidebar>
           </.test_layout>
           """)
           |> format_html() ==
             """
             <div class="Layout">
             <div class="Layout-sidebar">Sidebar content</div>
             <div class="Layout-main">Main content</div>
             </div>
             """
             |> format_html()
  end

  test "Specific order or slots: should maintain order" do
    # Test number string, string and integer
    assigns = []

    assert rendered_to_string(~H"""
           <.test_layout>
             <:sidebar order="1">
               Sidebar content
             </:sidebar>
             <:divider order="x"></:divider>
             <:main order={2}>
               Main content
             </:main>
           </.test_layout>
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

  test "Nested layout 1" do
    assigns = []

    assert rendered_to_string(~H"""
           <.test_layout>
             <:main>
               <.test_layout is_sidebar_position_end is_narrow_sidebar>
                 <:main>
                   Main content
                 </:main>
                 <:sidebar>
                   Metadata sidebar
                 </:sidebar>
               </.test_layout>
             </:main>
             <:sidebar>
               Default sidebar
             </:sidebar>
           </.test_layout>
           """)
           |> format_html() ==
             """
             <div class="Layout">
             <div class="Layout-sidebar">Default sidebar</div>
             <div class="Layout-main">
             <div class="Layout Layout--sidebar-narrow Layout--sidebarPosition-end">
             <div class="Layout-sidebar">Metadata sidebar</div>
             <div class="Layout-main">Main content</div>
             </div>
             </div>
             </div>
             """
             |> format_html()
  end

  test "Nested layout 2" do
    assigns = []

    assert rendered_to_string(~H"""
           <.test_layout>
             <:main>
               <.test_layout is_sidebar_position_end is_flow_row_until_lg is_narrow_sidebar>
                 <:main>
                   Main content
                 </:main>
                 <:sidebar>
                   Metadata sidebar
                 </:sidebar>
               </.test_layout>
             </:main>
             <:sidebar>
               Default sidebar
             </:sidebar>
           </.test_layout>
           """)
           |> format_html() ==
             """
             <div class="Layout">
             <div class="Layout-sidebar">Default sidebar</div>
             <div class="Layout-main">
             <div class="Layout Layout--sidebar-narrow Layout--sidebarPosition-end Layout--flowRow-until-lg">
             <div class="Layout-sidebar">Metadata sidebar</div>
             <div class="Layout-main">Main content</div>
             </div>
             </div>
             </div>
             """
             |> format_html()
  end

  test "Modifiers" do
    assigns = []

    assert rendered_to_string(~H"""
           <.test_layout is_narrow_sidebar></.test_layout>
           <.test_layout is_wide_sidebar></.test_layout>
           <.test_layout is_divided></.test_layout>
           <.test_layout is_gutter_none></.test_layout>
           <.test_layout is_gutter_condensed></.test_layout>
           <.test_layout is_gutter_spacious></.test_layout>
           <.test_layout is_sidebar_position_start></.test_layout>
           <.test_layout is_sidebar_position_end></.test_layout>
           <.test_layout is_sidebar_position_flow_row_start></.test_layout>
           <.test_layout is_sidebar_position_flow_row_end></.test_layout>
           <.test_layout is_sidebar_position_flow_row_none></.test_layout>
           <.test_layout is_flow_row_until_md></.test_layout>
           <.test_layout is_flow_row_until_lg></.test_layout>
           """)
           |> format_html() ==
             """
             <div class="Layout Layout--sidebar-narrow"></div>
             <div class="Layout Layout--sidebar-wide"></div>
             <div class="Layout Layout--divided"></div>
             <div class="Layout Layout--gutter-none"></div>
             <div class="Layout Layout--gutter-condensed"></div>
             <div class="Layout Layout--gutter-spacious"></div>
             <div class="Layout Layout--sidebarPosition-start"></div>
             <div class="Layout Layout--sidebarPosition-end"></div>
             <div class="Layout Layout--sidebarPosition-flowRow-start"></div>
             <div class="Layout Layout--sidebarPosition-flowRow-end"></div>
             <div class="Layout Layout--sidebarPosition-flowRow-none"></div>
             <div class="Layout Layout--flowRow-until-md"></div>
             <div class="Layout Layout--flowRow-until-lg"></div>
             """
             |> format_html()
  end

  test "Modifiers: is_centered_md, is_centered_lg, is_centered_xl" do
    assigns = []

    assert rendered_to_string(~H"""
           <.test_layout_with_slots is_centered_md />
           <.test_layout_with_slots is_centered_lg />
           <.test_layout_with_slots is_centered_xl />
           """)
           |> format_html() ==
             """
             <div class="Layout"><div class="Layout-sidebar">Sidebar content</div><div class="Layout-divider"></div><div class="Layout-main"><div class="Layout-main-centered-md">Main content</div></div></div>
             <div class="Layout"><div class="Layout-sidebar">Sidebar content</div><div class="Layout-divider"></div><div class="Layout-main"><div class="Layout-main-centered-lg">Main content</div></div></div>
             <div class="Layout"><div class="Layout-sidebar">Sidebar content</div><div class="Layout-divider"></div><div class="Layout-main"><div class="Layout-main-centered-xl">Main content</div></div></div>
             """
             |> format_html()
  end

  test "Modifiers: is_flow_row_shallow, is_flow_row_hidden" do
    assigns = []

    assert rendered_to_string(~H"""
           <.test_layout_with_slots is_divided is_flow_row_shallow />
           <.test_layout_with_slots is_divided is_flow_row_hidden />
           """)
           |> format_html() ==
             """
             <div class="Layout Layout--divided"><div class="Layout-sidebar">Sidebar content</div><div class="Layout-divider Layout-divider--flowRow-shallow"></div><div class="Layout-main">Main content</div></div>
             <div class="Layout Layout--divided"><div class="Layout-sidebar">Sidebar content</div><div class="Layout-divider Layout-divider--flowRow-hidden"></div><div class="Layout-main">Main content</div></div>
             """
             |> format_html()
  end

  test "Class" do
    assigns = []

    assert rendered_to_string(~H"""
           <.test_layout class="x"></.test_layout>
           """)
           |> format_html() ==
             """
             <div class="Layout x"></div>
             """
             |> format_html()
  end

  test "Extra attributes" do
    assigns = []

    assert rendered_to_string(~H"""
           <.test_layout dir="rtl"></.test_layout>
           """)
           |> format_html() ==
             """
             <div class="Layout" dir="rtl"></div>
             """
             |> format_html()
  end
end
