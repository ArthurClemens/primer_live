defmodule PrimerLive.TestComponents.BoxTest do
  use ExUnit.Case
  use PrimerLive
  import PrimerLive.Helpers.TestHelpers

  import Phoenix.Component
  import Phoenix.LiveViewTest

  test "Without attributes or slots" do
    assigns = []

    assert rendered_to_string(~H"""
           <.test_box>
             Content
           </.test_box>
           """)
           |> format_html() ==
             """
             <div class="Box">Content</div>
             """
             |> format_html()
  end

  test "Row slots" do
    assigns = []

    assert rendered_to_string(~H"""
           <.test_box>
             <:row>Row 1</:row>
             <:row>Row 2</:row>
             <:row>Row 3</:row>
           </.test_box>
           """)
           |> format_html() ==
             """
             <div class="Box">
             <div class="Box-row">Row 1</div>
             <div class="Box-row">Row 2</div>
             <div class="Box-row">Row 3</div>
             </div>
             """
             |> format_html()
  end

  test "Slots header, body, row, footer - should be placed in this order" do
    assigns = []

    assert rendered_to_string(~H"""
           <.test_box>
             <:header>
               Header
             </:header>
             <:body>
               Body
             </:body>
             <:row>Row</:row>
             <:footer>
               Footer
             </:footer>
           </.test_box>
           """)
           |> format_html() ==
             """
             <div class="Box">
             <div class="Box-header">Header</div>
             <div class="Box-body">Body</div>
             <div class="Box-row">Row</div>
             <div class="Box-footer">Footer</div>
             </div>
             """
             |> format_html()
  end

  test "Classes" do
    assigns = []

    assert rendered_to_string(~H"""
           <.test_box class="box-x">
             <:header class="header-x">
               Header
             </:header>
             <:header_title class="header-title-x">
               Title
             </:header_title>
             <:body class="body-x">
               Body
             </:body>
             <:row class="row-x">Row</:row>
             <:footer class="footer-x">
               Footer
             </:footer>
           </.test_box>
           """)
           |> format_html() ==
             """
             <div class="Box box-x">
             <div class="Box-header header-x"><h3 class="Box-title header-title-x">Title</h3>Header</div>
             <div class="Box-body body-x">Body</div>
             <div class="Box-row row-x">Row</div>
             <div class="Box-footer footer-x">Footer</div>
             </div>
             """
             |> format_html()
  end

  test "Body slot with alert" do
    assigns = %{show_alert: true}

    assert rendered_to_string(~H"""
           <.test_box>
             <.test_alert :if={@show_alert}>Alert message</.test_alert>
             <:body>
               Body
             </:body>
           </.test_box>
           """)
           |> format_html() ==
             """
             <div class="Box"><div class="flash">Alert message</div><div class="Box-body">Body</div></div>
             """
             |> format_html()
  end

  test "Header title without header slot" do
    assigns = []

    assert rendered_to_string(~H"""
           <.test_box>
             <:header_title>
               Title
             </:header_title>
             Content
           </.test_box>
           """)
           |> format_html() ==
             """
             <div class="Box">
             <div class="Box-header">
             <h3 class="Box-title">Title</h3>
             </div> Content
             </div>
             """
             |> format_html()
  end

  test "Header title with header slot" do
    assigns = []

    assert rendered_to_string(~H"""
           <.test_box>
             <:header>Header</:header>
             <:header_title>
               Title
             </:header_title>
             Content
           </.test_box>
           """)
           |> format_html() ==
             """
             <div class="Box">
             <div class="Box-header">
             <h3 class="Box-title">Title</h3>
             Header
             </div> Content
             </div>
             """
             |> format_html()
  end

  test "Header title with icon button" do
    assigns = []

    assert rendered_to_string(~H"""
           <.test_box>
             <:header class="d-flex flex-justify-between flex-items-start">
               <.test_button is_close_button aria-label="Close" class="flex-shrink-0 pl-4">
                 <.test_octicon name="x-16" />
               </.test_button>
             </:header>
             <:header_title>
               A very long title that wraps onto multiple lines without overlapping or wrapping underneath the icon to it's right
             </:header_title>
             <:body>Content</:body>
           </.test_box>
           """)
           |> format_html() ==
             """
             <div class="Box">
             <div class="Box-header d-flex flex-justify-between flex-items-start">
             <h3 class="Box-title">A very long title that wraps onto multiple lines without overlapping or wrapping underneath
             the icon to it's right</h3><button class="flex-shrink-0 pl-4 close-button" type="button" aria-label="Close"><svg
             class="octicon" xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16">
             <path fill-rule="evenodd"
             d="M3.72 3.72a.75.75 0 011.06 0L8 6.94l3.22-3.22a.75.75 0 111.06 1.06L9.06 8l3.22 3.22a.75.75 0 11-1.06 1.06L8 9.06l-3.22 3.22a.75.75 0 01-1.06-1.06L6.94 8 3.72 4.78a.75.75 0 010-1.06z">
             </path>
             </svg></button>
             </div>
             <div class="Box-body">Content</div>
             </div>
             """
             |> format_html()
  end

  test "Render result rows" do
    assigns = %{results: ["A", "B", "C"]}

    assert rendered_to_string(~H"""
           <.test_box>
             <:row :for={result <- @results}>
               <%= result %>
             </:row>
           </.test_box>
           """)
           |> format_html() ==
             """
             <div class="Box">
             <div class="Box-row">A</div>
             <div class="Box-row">B</div>
             <div class="Box-row">C</div>
             </div>
             """
             |> format_html()
  end

  test "Box modifiers" do
    assigns = []

    assert rendered_to_string(~H"""
           <.test_box is_blue>Content</.test_box>
           <.test_box is_danger>Content</.test_box>
           <.test_box is_border_dashed>Content</.test_box>
           <.test_box is_condensed>Content</.test_box>
           <.test_box is_spacious>Content</.test_box>
           """)
           |> format_html() ==
             """
             <div class="Box Box--blue">Content</div>
             <div class="Box Box--danger">Content</div>
             <div class="Box border-dashed">Content</div>
             <div class="Box Box--condensed">Content</div>
             <div class="Box Box--spacious">Content</div>
             """
             |> format_html()
  end

  test "Row modifiers" do
    assigns = []

    assert rendered_to_string(~H"""
           <.test_box>
             <:row is_blue>Content</:row>
             <:row is_gray>Content</:row>
             <:row is_yellow>Content</:row>
             <:row is_hover_blue>Content</:row>
             <:row is_hover_gray>Content</:row>
             <:row is_focus_blue>Content</:row>
             <:row is_focus_gray>Content</:row>
           </.test_box>
           """)
           |> format_html() ==
             """
             <div class="Box">
             <div class="Box-row Box-row--blue">Content</div>
             <div class="Box-row Box-row--gray">Content</div>
             <div class="Box-row Box-row--yellow">Content</div>
             <div class="Box-row Box-row--hover-blue">Content</div>
             <div class="Box-row Box-row--hover-gray">Content</div>
             <div class="Box-row Box-row--focus-blue">Content</div>
             <div class="Box-row Box-row--focus-gray">Content</div>
             </div>
             """
             |> format_html()
  end

  test "Row with is_link" do
    assigns = []

    assert rendered_to_string(~H"""
           <.test_box>
             <:row is_link href="/home" class="link-x" is_gray>
               Go to home
             </:row>
           </.test_box>
           """)
           |> format_html() ==
             """
             <div class="Box">
             <div class="Box-row link-x Box-row--gray">
             <a href="/home" class="Box-row-link">Go to home</a>
             </div>
             </div>
             """
             |> format_html()
  end

  test "Extra attributes" do
    assigns = []

    assert rendered_to_string(~H"""
           <.test_box dir="rtl">Content</.test_box>
           """)
           |> format_html() ==
             """
             <div class="Box" dir="rtl">Content</div>
             """
             |> format_html()
  end
end
