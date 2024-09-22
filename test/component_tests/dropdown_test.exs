defmodule PrimerLive.TestComponents.DropdownTest do
  @moduledoc false

  use PrimerLive.TestBase

  test "Attribute: is_backdrop" do
    assigns = %{}

    run_test(
      ~H"""
      <.dropdown id="my-dropdown" is_backdrop>
        <:toggle>Menu</:toggle>
        <:item>item</:item>
        <:item>item</:item>
        <:item>item</:item>
      </.dropdown>
      """,
      __ENV__
    )
  end

  test "Attribute: is_dropdown_caret (false)" do
    assigns = %{}

    run_test(
      ~H"""
      <.dropdown id="my-dropdown" is_dropdown_caret={false}>
        <:toggle>Menu</:toggle>
        <:item>item</:item>
        <:item>item</:item>
        <:item>item</:item>
      </.dropdown>
      """,
      __ENV__
    )
  end

  test "Slot: item (various types)" do
    assigns = %{}

    run_test(
      ~H"""
      <.dropdown id="my-dropdown">
        <:toggle>Menu</:toggle>
        <:item href="#url">
          href link
        </:item>
        <:item navigate="#url">
          navigate link
        </:item>
        <:item patch="#url">
          patch link
        </:item>
      </.dropdown>
      """,
      __ENV__
    )
  end

  test "Slot: menu with title" do
    assigns = %{}

    run_test(
      ~H"""
      <.dropdown id="my-dropdown">
        <:toggle>Menu</:toggle>
        <:menu title="Menu title" />
        <:item href="#url">
          Item 1
        </:item>
        <:item href="#url">
          Item 2
        </:item>
      </.dropdown>
      """,
      __ENV__
    )
  end

  test "Slot: menu with position" do
    assigns = %{}

    run_test(
      ~H"""
      <.dropdown id="my-dropdown">
        <:toggle>Menu</:toggle>
        <:menu position="e" />
        <:item href="#url">
          Item 1
        </:item>
        <:item href="#url">
          Item 2
        </:item>
      </.dropdown>
      """,
      __ENV__
    )
  end

  test "Slot: item" do
    assigns = %{}

    run_test(
      ~H"""
      <.dropdown id="my-dropdown">
        <:toggle>Menu</:toggle>
        <:item href="#url">
          Item 1
        </:item>
        <:item href="#url">
          Item 2
        </:item>
      </.dropdown>
      """,
      __ENV__
    )
  end

  test "Slot: items with divider" do
    assigns = %{}

    run_test(
      ~H"""
      <.dropdown id="my-dropdown">
        <:toggle>Menu</:toggle>
        <:item href="#url">
          Item 1
        </:item>
        <:item href="#url">
          Item 2
        </:item>
        <:item is_divider />
        <:item is_divider class="my-divider" />
        <:item href="#url">
          Item 3
        </:item>
      </.dropdown>
      """,
      __ENV__
    )
  end

  test "Attribute: classes" do
    assigns = %{}

    run_test(
      ~H"""
      <.dropdown
        id="my-dropdown"
        class="my-dropdown"
        classes={
          %{
            dropdown: "dropdown-x",
            toggle: "toggle-x",
            caret: "caret-x",
            menu: "menu-x",
            item: "item-x",
            divider: "divider-x",
            header: "header-x"
          }
        }
      >
        <:toggle class="my-toggle">Menu</:toggle>
        <:menu title="Menu title" />
        <:item href="#url" class="my-item">
          Item 1
        </:item>
        <:item href="#url">
          Item 2
        </:item>
        <:item is_divider class="my-divider" />
        <:item href="#url">
          Item 3
        </:item>
      </.dropdown>
      """,
      __ENV__
    )
  end

  test "Extra attributes" do
    assigns = %{}

    run_test(
      ~H"""
      <.dropdown id="my-dropdown" dir="rtl">
        <:toggle>Menu</:toggle>
        <:item href="#url">
          Item 1
        </:item>
        <:item href="#url">
          Item 2
        </:item>
      </.dropdown>
      """,
      __ENV__
    )
  end
end
