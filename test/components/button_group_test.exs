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
             <button class="btn" type="button"><span class="pl-button__content">Button 1</span></button>
             <button aria-selected="true" class="btn" type="button"><span class="pl-button__content">Button 2</span></button>
             <button class="btn btn-danger" type="button"><span class="pl-button__content">Button 3</span></button>
             <button class="btn button-x" type="button"><span class="pl-button__content">Button 4</span></button>
             </div>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
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
             <button class="btn" type="button"><span class="pl-button__content">Button 1</span></button>
             <button aria-selected="true" class="btn" type="button"><span class="pl-button__content">Button 2</span></button>
             <button class="btn btn-danger" type="button"><span class="pl-button__content">Button 3</span></button>
             <button class="btn button-x" type="button"><span class="pl-button__content">Button 4</span></button>
             </div>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
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
             <button class="btn" type="button"><span class="pl-button__content">Button 1</span></button>
             <button class="btn" type="button"><span class="pl-button__content">Button 2</span></button>
             </div>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
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
             <button class="btn" type="button"><span class="pl-button__content">Button 1</span></button>
             <button class="btn" type="button"><span class="pl-button__content">Button 2</span></button>
             </div>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end
end
