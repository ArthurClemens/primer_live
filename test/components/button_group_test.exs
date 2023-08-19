defmodule PrimerLive.TestComponents.ButtonGroupTest do
  use ExUnit.Case
  use PrimerLive
  import PrimerLive.Helpers.TestHelpers

  import Phoenix.Component
  import Phoenix.LiveViewTest

  test "Button children" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.button_group>
             <.button>Button 1</.button>
             <.button is_selected>Button 2</.button>
             <.button is_danger>Button 3</.button>
             <.button class="button-x">Button 4</.button>
           </.button_group>
           """)
           |> format_html() ==
             """
             <div class="pl-button-group">
             <button class="btn" type="button">Button 1</button>
             <button aria-selected="true" class="btn" type="button">Button 2</button>
             <button class="btn btn-danger" type="button">Button 3</button>
             <button class="btn button-x" type="button">Button 4</button>
             </div>
             """
             |> format_html()
  end

  test "Button slots (deprecated)" do
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
             <div class="pl-button-group">
             <button class="btn" type="button">Button 1</button>
             <button aria-selected="true" class="btn" type="button">Button 2</button>
             <button class="btn btn-danger" type="button">Button 3</button>
             <button class="btn button-x" type="button">Button 4</button>
             </div>
             """
             |> format_html()
  end

  test "Class" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.button_group class="button-group-x">
             <.button>Button 1</.button>
             <.button>Button 2</.button>
           </.button_group>
           """)
           |> format_html() ==
             """
             <div class="pl-button-group button-group-x">
             <button class="btn" type="button">Button 1</button>
             <button class="btn" type="button">Button 2</button>
             </div>
             """
             |> format_html()
  end

  test "Extra attributes" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.button_group dir="rtl">
             <.button>Button 1</.button>
             <.button>Button 2</.button>
           </.button_group>
           """)
           |> format_html() ==
             """
             <div class="pl-button-group" dir="rtl">
             <button class="btn" type="button">Button 1</button>
             <button class="btn" type="button">Button 2</button>
             </div>
             """
             |> format_html()
  end
end
