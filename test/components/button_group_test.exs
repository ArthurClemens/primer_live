defmodule PrimerLive.TestComponents.ButtonGroupTest do
  @moduledoc false

  use PrimerLive.TestBase

  test "Button children" do
    assigns = %{}

    run_test(
      ~H"""
      <.button_group>
        <.button>Button 1</.button>
        <.button is_selected>Button 2</.button>
        <.button is_danger>Button 3</.button>
        <.button class="button-x">Button 4</.button>
      </.button_group>
      """,
      __ENV__
    )
  end

  test "Button slots (deprecated)" do
    assigns = %{}

    run_test(
      ~H"""
      <.button_group>
        <:button>Button 1</:button>
        <:button is_selected>Button 2</:button>
        <:button is_danger>Button 3</:button>
        <:button class="button-x">Button 4</:button>
      </.button_group>
      """,
      __ENV__
    )
  end

  test "Class" do
    assigns = %{}

    run_test(
      ~H"""
      <.button_group class="button-group-x">
        <.button>Button 1</.button>
        <.button>Button 2</.button>
      </.button_group>
      """,
      __ENV__
    )
  end

  test "Extra attributes" do
    assigns = %{}

    run_test(
      ~H"""
      <.button_group dir="rtl">
        <.button>Button 1</.button>
        <.button>Button 2</.button>
      </.button_group>
      """,
      __ENV__
    )
  end
end
