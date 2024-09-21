defmodule PrimerLive.TestComponents.SelectMenuTest do
  @moduledoc false

  use PrimerLive.TestBase

  test "Slot: item (various types)" do
    assigns = %{}

    run_test(
      ~H"""
      <.select_menu id="querty">
        <:toggle>Menu</:toggle>
        <:item>
          Button
        </:item>
        <:item is_divider>
          Divider
        </:item>
        <:item href="#url">
          href link
        </:item>
        <:item navigate="#url">
          navigate link
        </:item>
        <:item patch="#url">
          patch link
        </:item>
        <:item is_divider />
        <:item>
          Button
        </:item>
      </.select_menu>
      """,
      __ENV__
    )
  end

  test "Slot: item (various types, is_disabled)" do
    assigns = %{}

    run_test(
      ~H"""
      <.select_menu id="querty">
        <:toggle>Menu</:toggle>
        <:item is_disabled>
          Button
        </:item>
        <:item href="#url" is_disabled>
          Link
        </:item>
      </.select_menu>
      """,
      __ENV__
    )
  end

  test "Slot: item (is_selected)" do
    assigns = %{}

    run_test(
      ~H"""
      <.select_menu id="querty">
        <:toggle>Menu</:toggle>
        <:item is_selected>
          Button
        </:item>
        <:item is_divider>
          Divider
        </:item>
        <:item href="#url" is_selected>
          Link
        </:item>
        <:item is_divider />
        <:item>
          Button
        </:item>
      </.select_menu>
      """,
      __ENV__
    )
  end

  test "Slot: menu with title" do
    assigns = %{}

    run_test(
      ~H"""
      <.select_menu id="my-menu-id">
        <:toggle>Menu</:toggle>
        <:menu title="Title" />
        <:item>
          Item 1
        </:item>
        <:item>
          Item 2
        </:item>
      </.select_menu>
      """,
      __ENV__
    )
  end

  test "Slot: footer" do
    assigns = %{}

    run_test(
      ~H"""
      <.select_menu id="querty">
        <:toggle>Menu</:toggle>
        <:item>
          Item 1
        </:item>
        <:item>
          Item 2
        </:item>
        <:footer>Footer</:footer>
      </.select_menu>
      """,
      __ENV__
    )
  end

  test "Slot: filter" do
    assigns = %{}

    run_test(
      ~H"""
      <.select_menu id="querty">
        <:toggle>Menu</:toggle>
        <:filter>
          <form>
            <.text_input class="SelectMenu-input" type="search" name="q" placeholder="Filter" />
          </form>
        </:filter>
        <:item>
          Item 1
        </:item>
        <:item>
          Item 2
        </:item>
      </.select_menu>
      """,
      __ENV__
    )
  end

  test "Slot: tab" do
    assigns = %{}

    run_test(
      ~H"""
      <.select_menu id="querty">
        <:toggle>Menu</:toggle>
        <:tab is_selected>
          Selected tab
        </:tab>
        <:tab>
          Other tab
        </:tab>
        <:item>
          Item 1
        </:item>
        <:item>
          Item 2
        </:item>
      </.select_menu>
      """,
      __ENV__
    )
  end

  test "Slot: loading" do
    assigns = %{}

    run_test(
      ~H"""
      <.select_menu id="querty">
        <:toggle>Menu</:toggle>
        <:loading><.octicon name="copilot-48" class="anim-pulse" /></:loading>
      </.select_menu>
      """,
      __ENV__
    )
  end

  test "Slot: blankslate" do
    assigns = %{}

    run_test(
      ~H"""
      <.select_menu id="querty">
        <:toggle>Menu</:toggle>
        <:blankslate>Blankslate content</:blankslate>
      </.select_menu>
      """,
      __ENV__
    )
  end

  test "Slot: message" do
    assigns = %{}

    run_test(
      ~H"""
      <.select_menu id="querty">
        <:toggle>Menu</:toggle>
        <:message class="color-bg-danger color-fg-danger">Message</:message>
      </.select_menu>
      """,
      __ENV__
    )
  end

  test "Attribute: is_borderless" do
    assigns = %{}

    run_test(
      ~H"""
      <.select_menu is_borderless id="querty">
        <:toggle>Menu</:toggle>
        <:item>
          Item 1
        </:item>
        <:item>
          Item 2
        </:item>
      </.select_menu>
      """,
      __ENV__
    )
  end

  test "Attribute: is_aligned_end" do
    assigns = %{}

    run_test(
      ~H"""
      <.select_menu is_aligned_end id="querty">
        <:toggle>Menu</:toggle>
        <:item>
          Item 1
        </:item>
        <:item>
          Item 2
        </:item>
      </.select_menu>
      """,
      __ENV__
    )
  end

  test "Classes" do
    assigns = %{}

    run_test(
      ~H"""
      <.select_menu
        classes={
          %{
            select_menu: "select_menu-x",
            blankslate: "blankslate-x",
            caret: "caret-x",
            divider: "divider-x",
            filter: "filter-x",
            footer: "footer-x",
            header_close_button: "header_close_button-x",
            header: "header-x",
            item: "item-x",
            loading: "loading-x",
            menu_container: "menu_container-x",
            menu_list: "menu_list-x",
            menu_title: "menu_title-x",
            menu: "menu-x",
            message: "message-x",
            tabs: "tabs-x",
            tab: "tab-x",
            toggle: "toggle-x"
          }
        }
        class="my-select-menu"
        id="my-menu-id"
        is_dropdown_caret
      >
        <:toggle class="my-toggle">Menu</:toggle>
        <:blankslate class="my-blankslate">Blankslate content</:blankslate>
        <:loading class="my-loading"><.octicon name="copilot-48" class="anim-pulse" /></:loading>
        <:menu title="Title" class="my-menu" />
        <:filter class="my-filter">
          Filter
        </:filter>
        <:item class="my-item">
          Item 1
        </:item>
        <:item>
          Item 2
        </:item>
        <:tab is_selected class="my-tab">
          Selected tab
        </:tab>
        <:tab>
          Other tab
        </:tab>
        <:message class="my-message">Message</:message>
        <:footer class="my-footer">Footer</:footer>
      </.select_menu>
      """,
      __ENV__
    )
  end

  test "Extra attributes" do
    assigns = %{}

    run_test(
      ~H"""
      <.select_menu dir="rtl" id="querty">
        <:toggle>Menu</:toggle>
        <:item>
          Item 1
        </:item>
        <:item>
          Item 2
        </:item>
      </.select_menu>
      """,
      __ENV__
    )
  end
end
