defmodule PrimerLive.Components.ButtonGroupTest do
  use ExUnit.Case
  use PrimerLive
  import PrimerLive.Helpers.TestHelpers

  import Phoenix.Component
  import Phoenix.LiveViewTest

  test "Called without options or inner_block: should render an error message" do
    assigns = []

    assert rendered_to_string(~H"""
           <.button_group />
           """)
           |> format_html() ==
             """
             <div class="flash flash-error"><p>button_group component received invalid options:</p><p>inner_block: can&#39;t be blank</p></div>
             """
             |> format_html()
  end

  test "Called with child elements: should render the button group" do
    assigns = []

    assert rendered_to_string(~H"""
           <.button_group>
             <.button_group_item>Button 1</.button_group_item>
             <.button_group_item is_selected>Button 2</.button_group_item>
             <.button_group_item is_danger>Button 3</.button_group_item>
           </.button_group>
           """)
           |> format_html() ==
             """
             <div class="BtnGroup"><button class="btn BtnGroup-item" type="button">Button 1</button><button class="btn BtnGroup-item"
             type="button" aria-selected="true">Button 2</button><button class="btn BtnGroup-item btn-danger"
             type="button">Button 3</button></div>
             """
             |> format_html()
  end

  test "Option: class" do
    assigns = []

    assert rendered_to_string(~H"""
           <.button_group class="x">
             <.button_group_item>Button 1</.button_group_item>
             <.button_group_item is_selected>Button 2</.button_group_item>
           </.button_group>
           """)
           |> format_html() ==
             """
             <div class="BtnGroup x"><button class="btn BtnGroup-item" type="button">Button 1</button><button class="btn BtnGroup-item"
             type="button" aria-selected="true">Button 2</button></div>
             """
             |> format_html()
  end

  test "Extra attributes" do
    assigns = []

    assert rendered_to_string(~H"""
           <.button_group dir="rtl">
             <.button_group_item>Button 1</.button_group_item>
             <.button_group_item is_selected>Button 2</.button_group_item>
           </.button_group>
           """)
           |> format_html() ==
             """
             <div class="BtnGroup" dir="rtl"><button class="btn BtnGroup-item" type="button">Button 1</button><button class="btn BtnGroup-item"
             type="button" aria-selected="true">Button 2</button></div>
             """
             |> format_html()
  end
end
