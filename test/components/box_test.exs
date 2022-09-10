defmodule PrimerLive.Components.BoxTest do
  use ExUnit.Case
  use PrimerLive
  import PrimerLive.Helpers.TestHelpers

  import Phoenix.LiveView.Helpers
  import Phoenix.LiveViewTest

  test "Called without options or inner_block: should render an error message" do
    assigns = []

    assert rendered_to_string(~H"""
           <.box />
           """)
           |> format_html() ==
             """
             <div class="flash flash-error"><p>box component received invalid options:</p><p>inner_block: can&#39;t be blank</p></div>
             """
             |> format_html()
  end

  test "Called without options: should render the box element" do
    assigns = []

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

  test "With box_row elements" do
    assigns = []

    assert rendered_to_string(~H"""
           <.box>
             <.box_slot row>Row 1</.box_slot>
             <.box_slot row>Row 2</.box_slot>
             <.box_slot row>Row 3</.box_slot>
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

  test "box_slot header, body, footer - should be placed in this order" do
    assigns = []

    assert rendered_to_string(~H"""
           <.box>
             <.box_slot header>
               Header
             </.box_slot>
             <.box_slot body>
               Body
             </.box_slot>
             <.box_slot footer>
               Footer
             </.box_slot>
           </.box>
           """)
           |> format_html() ==
             """
             <div class="Box">
             <div class="Box-header">Header</div>
             <div class="Box-body">Body</div>
             <div class="Box-footer">Footer</div>
             </div>
             """
             |> format_html()
  end

  test "box_slot body with alert" do
    assigns = []

    assert rendered_to_string(~H"""
           <.box>
             <.alert>Alert message</.alert>
             <.box_slot body>
               Body
             </.box_slot>
           </.box>
           """)
           |> format_html() ==
             """
             <div class="Box"><div class="flash">Alert message</div><div class="Box-body">Body</div></div>
             """
             |> format_html()
  end

  test "box_slot title" do
    assigns = []

    assert rendered_to_string(~H"""
           <.box>
             <.box_slot header>
               <.box_slot title>
                 Title
               </.box_slot>
             </.box_slot>
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

  test "Option: is_blue" do
    assigns = []

    assert rendered_to_string(~H"""
           <.box is_blue>Content</.box>
           """)
           |> format_html() ==
             """
             <div class="Box Box--blue">Content</div>
             """
             |> format_html()
  end

  test "Option: is_danger" do
    assigns = []

    assert rendered_to_string(~H"""
           <.box is_danger>Content</.box>
           """)
           |> format_html() ==
             """
             <div class="Box Box--danger">Content</div>
             """
             |> format_html()
  end

  test "Option: is_border_dashed" do
    assigns = []

    assert rendered_to_string(~H"""
           <.box is_border_dashed>Content</.box>
           """)
           |> format_html() ==
             """
             <div class="Box border-dashed">Content</div>
             """
             |> format_html()
  end

  test "Option: is_condensed" do
    assigns = []

    assert rendered_to_string(~H"""
           <.box is_condensed>Content</.box>
           """)
           |> format_html() ==
             """
             <div class="Box Box--condensed">Content</div>
             """
             |> format_html()
  end

  test "Option: is_spacious" do
    assigns = []

    assert rendered_to_string(~H"""
           <.box is_spacious>Content</.box>
           """)
           |> format_html() ==
             """
             <div class="Box Box--spacious">Content</div>
             """
             |> format_html()
  end

  test "Option: class" do
    assigns = []

    assert rendered_to_string(~H"""
           <.box class="x">Content</.box>
           """)
           |> format_html() ==
             """
             <div class="Box x">Content</div>
             """
             |> format_html()
  end

  test "Extra attributes" do
    assigns = []

    assert rendered_to_string(~H"""
           <.box dir="rtl">Content</.box>
           """)
           |> format_html() ==
             """
             <div class="Box" dir="rtl">Content</div>
             """
             |> format_html()
  end
end
