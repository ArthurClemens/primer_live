defmodule PrimerLive.TestComponents.LayoutTest do
  use ExUnit.Case
  use PrimerLive
  import PrimerLive.Helpers.TestHelpers

  import Phoenix.Component
  import Phoenix.LiveViewTest

  defp layout_with_slots(assigns) do
    ~H"""
    <.layout {assigns}>
      <:main>
        Main content
      </:main>
      <:divider></:divider>
      <:sidebar>
        Sidebar content
      </:sidebar>
    </.layout>
    """
  end

  test "Without attributes or slots" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.layout></.layout>
           """)
           |> format_html() ==
             """
             <div class="Layout"></div>
             """
             |> format_html()
  end

  test "Slots" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.layout>
             <:main>
               Main content
             </:main>
             <:sidebar>
               Sidebar content
             </:sidebar>
           </.layout>
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

  test "Specific order of slots: should maintain order" do
    # Test number string, string and integer
    assigns = %{}

    assert rendered_to_string(~H"""
           <.layout>
             <:sidebar order="1">
               Sidebar content
             </:sidebar>
             <:divider order="x"></:divider>
             <:main order={2}>
               Main content
             </:main>
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

  test "Swapped order of slots" do
    # Test number string, string and integer
    assigns = %{}

    assert rendered_to_string(~H"""
           <.layout>
             <:sidebar order="2">
               Sidebar content
             </:sidebar>
             <:divider order="0"></:divider>
             <:main order={1}>
               Main content
             </:main>
           </.layout>
           """)
           |> format_html() ==
             """
             <div class="Layout">
             <div class="Layout-main">Main content</div>
             <div class="Layout-divider"></div>
             <div class="Layout-sidebar">Sidebar content</div>
             </div>
             """
             |> format_html()
  end

  test "Nested layout 1" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.layout>
             <:main>
               <.layout is_sidebar_position_end is_narrow_sidebar>
                 <:main>
                   Main content
                 </:main>
                 <:sidebar>
                   Metadata sidebar
                 </:sidebar>
               </.layout>
             </:main>
             <:sidebar>
               Default sidebar
             </:sidebar>
           </.layout>
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
    assigns = %{}

    assert rendered_to_string(~H"""
           <.layout>
             <:main>
               <.layout is_sidebar_position_end is_flow_row_until_lg is_narrow_sidebar>
                 <:main>
                   Main content
                 </:main>
                 <:sidebar>
                   Metadata sidebar
                 </:sidebar>
               </.layout>
             </:main>
             <:sidebar>
               Default sidebar
             </:sidebar>
           </.layout>
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
    assigns = %{}

    assert rendered_to_string(~H"""
           <.layout is_narrow_sidebar></.layout>
           <.layout is_wide_sidebar></.layout>
           <.layout is_divided></.layout>
           <.layout is_gutter_none></.layout>
           <.layout is_gutter_condensed></.layout>
           <.layout is_gutter_spacious></.layout>
           <.layout is_sidebar_position_start></.layout>
           <.layout is_sidebar_position_end></.layout>
           <.layout is_sidebar_position_flow_row_start></.layout>
           <.layout is_sidebar_position_flow_row_end></.layout>
           <.layout is_sidebar_position_flow_row_none></.layout>
           <.layout is_flow_row_until_md></.layout>
           <.layout is_flow_row_until_lg></.layout>
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
    assigns = %{}

    assert rendered_to_string(~H"""
           <.layout_with_slots is_centered_md />
           <.layout_with_slots is_centered_lg />
           <.layout_with_slots is_centered_xl />
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
    assigns = %{}

    assert rendered_to_string(~H"""
           <.layout_with_slots is_divided is_flow_row_shallow />
           <.layout_with_slots is_divided is_flow_row_hidden />
           """)
           |> format_html() ==
             """
             <div class="Layout Layout--divided"><div class="Layout-sidebar">Sidebar content</div><div class="Layout-divider Layout-divider--flowRow-shallow"></div><div class="Layout-main">Main content</div></div>
             <div class="Layout Layout--divided"><div class="Layout-sidebar">Sidebar content</div><div class="Layout-divider Layout-divider--flowRow-hidden"></div><div class="Layout-main">Main content</div></div>
             """
             |> format_html()
  end

  test "Attribute: classes" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.layout_with_slots
             is_centered_md
             class="my-layout"
             classes={
               %{
                 layout: "layout-x",
                 main: "main-x",
                 main_center_wrapper: "main_center_wrapper-x",
                 sidebar: "sidebar-x",
                 divider: "divider-x"
               }
             }
           />
           """)
           |> format_html() ==
             """
             <div class="Layout layout-x my-layout">
             <div class="Layout-sidebar sidebar-x">Sidebar content</div>
             <div class="Layout-divider divider-x"></div>
             <div class="Layout-main main-x">
             <div class="Layout-main-centered-md main_center_wrapper-x">Main content</div>
             </div>
             </div>
             """
             |> format_html()
  end

  test "Extra attributes" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.layout dir="rtl"></.layout>
           """)
           |> format_html() ==
             """
             <div class="Layout" dir="rtl"></div>
             """
             |> format_html()
  end
end
