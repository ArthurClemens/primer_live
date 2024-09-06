defmodule PrimerLive.TestComponents.BoxTest do
  use ExUnit.Case
  use PrimerLive
  import PrimerLive.Helpers.TestHelpers

  import Phoenix.Component
  import Phoenix.LiveViewTest

  test "Without attributes or slots" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.box>
             Content
           </.box>
           """)
           |> format_html() ==
             """
             <div class="Box">Content</div>
             """
             |> format_html()
  end

  test "Row slots" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.box>
             <:row>Row 1</:row>
             <:row>Row 2</:row>
             <:row>Row 3</:row>
           </.box>
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
    assigns = %{}

    assert rendered_to_string(~H"""
           <.box>
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
           </.box>
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
    assigns = %{}

    assert rendered_to_string(~H"""
           <.box
             class="box-x"
             classes={
               %{
                 box: "box-x",
                 header: "header-x",
                 row: "row-x",
                 body: "body-x",
                 footer: "footer-x",
                 header_title: "header_title-x",
                 link: "link-x"
               }
             }
           >
             <:header class="my-header">
               Header
             </:header>
             <:header_title class="my-header-title">
               Title
             </:header_title>
             <:body class="my-body">
               Body
             </:body>
             <:row class="my-row">Row</:row>
             <:footer class="my-footer">
               Footer
             </:footer>
           </.box>
           """)
           |> format_html() ==
             """
             <div class="Box box-x">
             <div class="Box-header header-x my-header">
             <h3 class="Box-title header_title-x my-header-title">Title</h3>Header
             </div>
             <div class="Box-body body-x my-body">Body</div>
             <div class="Box-row row-x my-row">Row</div>
             <div class="Box-footer footer-x my-footer">Footer</div>
             </div>
             """
             |> format_html()
  end

  test "Body slot with alert" do
    assigns = %{show_alert: true}

    assert rendered_to_string(~H"""
           <.box>
             <.alert :if={@show_alert}>Alert message</.alert>
             <:body>
               Body
             </:body>
           </.box>
           """)
           |> format_html() ==
             """
             <div class="Box"><div class="flash">Alert message</div><div class="Box-body">Body</div></div>
             """
             |> format_html()
  end

  test "Header title without header slot" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.box>
             <:header_title>
               Title
             </:header_title>
             Content
           </.box>
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
    assigns = %{}

    assert rendered_to_string(~H"""
           <.box>
             <:header>Header</:header>
             <:header_title>
               Title
             </:header_title>
             Content
           </.box>
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
    assigns = %{}

    assert rendered_to_string(~H"""
           <.box>
             <:header class="d-flex flex-justify-between flex-items-start">
               <.button is_close_button aria-label="Close" class="flex-shrink-0 pl-4">
                 <.octicon name="x-16" />
               </.button>
             </:header>
             <:header_title>
               A very long title that wraps onto multiple lines without overlapping or wrapping underneath the icon to it's right
             </:header_title>
             <:body>Content</:body>
           </.box>
           """)
           |> format_html() ==
             """
             <div class="Box">
             <div class="Box-header d-flex flex-justify-between flex-items-start">
             <h3 class="Box-title">A very long title that wraps onto multiple lines without overlapping or wrapping underneath
             the icon to it's right</h3><button aria-label="Close" class="close-button flex-shrink-0 pl-4" type="button"><span class="pl-button__content"><svg
             class="octicon" xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16">
             <path fill-rule="evenodd"
             d="M3.72 3.72a.75.75 0 011.06 0L8 6.94l3.22-3.22a.75.75 0 111.06 1.06L9.06 8l3.22 3.22a.75.75 0 11-1.06 1.06L8 9.06l-3.22 3.22a.75.75 0 01-1.06-1.06L6.94 8 3.72 4.78a.75.75 0 010-1.06z">
             </path>
             </svg></span></button>
             </div>
             <div class="Box-body">Content</div>
             </div>
             """
             |> format_html()
  end

  test "Render result rows" do
    assigns = %{results: ["A", "B", "C"]}

    assert rendered_to_string(~H"""
           <.box>
             <:row :for={result <- @results}>
               <%= result %>
             </:row>
           </.box>
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
    assigns = %{}

    assert rendered_to_string(~H"""
           <.box is_blue>Content</.box>
           <.box is_danger>Content</.box>
           <.box is_border_dashed>Content</.box>
           <.box is_condensed>Content</.box>
           <.box is_spacious>Content</.box>
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
    assigns = %{}

    assert rendered_to_string(~H"""
           <.box>
             <:row is_blue>Content</:row>
             <:row is_gray>Content</:row>
             <:row is_yellow>Content</:row>
             <:row is_hover_blue>Content</:row>
             <:row is_hover_gray>Content</:row>
             <:row is_focus_blue>Content</:row>
             <:row is_focus_gray>Content</:row>
           </.box>
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

  test "Rows as links" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.box>
             <:row href="#url">
               href link
             </:row>
             <:row navigate="#url">
               navigate link
             </:row>
             <:row patch="#url">
               patch link
             </:row>
           </.box>
           """)
           |> format_html() ==
             """
             <div class="Box">
             <a href="#url" class="Box-row d-block">href link</a>
             <a href="#url" data-phx-link="redirect" data-phx-link-state="push" class="Box-row d-block">navigate link</a>
             <a href="#url" data-phx-link="patch" data-phx-link-state="push" class="Box-row d-block">patch link</a>
             </div>
             """
             |> format_html()
  end

  test "Row with link" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.box classes={%{link: "link-x"}}>
             <:row :let={%{classes: classes}}>
               <.link href="/" class={["my-link", classes.link]}>Home</.link>
             </:row>
           </.box>
           """)
           |> format_html() ==
             """
             <div class="Box">
             <div class="Box-row">
             <a href="/" class="my-link Box-row-link link-x">Home</a>
             </div>
             </div>
             """
             |> format_html()
  end

  test "Attribute: is_scrollable" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.box is_scrollable style="max-height: 400px">
             <:header>Header</:header>
             <p>General info</p>
             <:body>Body</:body>
             <:row>Row 1</:row>
             <:row>Row 2</:row>
             <:row>Row 3</:row>
             <:row>Row 4</:row>
             <:row>Row 5</:row>
             <:footer>Footer</:footer>
           </.box>
           """)
           |> format_html() ==
             """
             <div class="Box d-flex flex-column" style="max-height: 400px">
             <div class="Box-header">Header</div>
             <div class="overflow-auto">
             <p>General info</p>
             <div class="Box-body">Body</div>
             <div class="Box-row">Row 1</div>
             <div class="Box-row">Row 2</div>
             <div class="Box-row">Row 3</div>
             <div class="Box-row">Row 4</div>
             <div class="Box-row">Row 5</div>
             </div>
             <div class="Box-footer">Footer</div>
             </div>
             """
             |> format_html()
  end

  test "Extra attributes" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.box dir="rtl">Content</.box>
           """)
           |> format_html() ==
             """
             <div class="Box" dir="rtl">Content</div>
             """
             |> format_html()
  end

  test "Attribute: style" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.box style="border: 1px solid red;"></.box>
           """)
           |> format_html() ==
             """
             <div class="Box" style="border: 1px solid red;"></div>
             """
             |> format_html()
  end
end
