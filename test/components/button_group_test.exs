defmodule PrimerLive.TestComponents.ButtonGroupTest do
  use ExUnit.Case
  use PrimerLive
  import PrimerLive.Helpers.TestHelpers

  import Phoenix.Component
  import Phoenix.LiveViewTest

  test "Button slots" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.button_group>
             <:button>Button 1</:button>
             <:button is_selected>Button 2</:button>
             <:button is_danger>Button 3</:button>
             <:button class="button-x">Button 4</:button>
           </.button_group>
           """)
           |> format_html() ==
             """
             <div class="BtnGroup">
             <button class="btn BtnGroup-item" type="button">Button 1</button>
             <button aria-selected="true" class="btn BtnGroup-item" type="button">Button 2</button>
             <button class="btn btn-danger BtnGroup-item" type="button">Button 3</button>
             <button class="btn BtnGroup-item button-x" type="button">Button 4</button>
             </div>
             """
             |> format_html()
  end

  test "Class" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.button_group class="button-group-x">
             <:button>Button 1</:button>
             <:button>Button 2</:button>
           </.button_group>
           """)
           |> format_html() ==
             """
             <div class="BtnGroup button-group-x">
             <button class="btn BtnGroup-item" type="button">Button 1</button>
             <button class="btn BtnGroup-item" type="button">Button 2</button>
             </div>
             """
             |> format_html()
  end

  test "Extra attributes" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.button_group dir="rtl">
             <:button>Button 1</:button>
             <:button>Button 2</:button>
           </.button_group>
           """)
           |> format_html() ==
             """
             <div class="BtnGroup" dir="rtl">
             <button class="btn BtnGroup-item" type="button">Button 1</button>
             <button class="btn BtnGroup-item" type="button">Button 2</button>
             </div>
             """
             |> format_html()
  end
end
