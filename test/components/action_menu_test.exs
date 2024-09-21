defmodule PrimerLive.TestComponents.ActionMenuTest do
  @moduledoc false

  use PrimerLive.TestBase

  test "Basic" do
    assigns = %{}

    run_test(
      ~H"""
      <.action_menu id="my-menu">
        <:toggle phx-click={open_menu("my-menu")}>Menu</:toggle>
        <.action_list>
          <.action_list_item>
            One
          </.action_list_item>
          <.action_list_item>
            Two
          </.action_list_item>
          <.action_list_item>
            Three
          </.action_list_item>
        </.action_list>
      </.action_menu>
      """,
      __ENV__
    )
  end

  test "With single select" do
    assigns = %{}

    run_test(
      ~H"""
      <.action_menu is_dropdown_caret id="my-menu">
        <:toggle phx-click={toggle_menu("my-menu")}>
          <.octicon name="number-16" /><span>Number</span>
        </:toggle>
        <.action_list>
          <.action_list_item is_single_select input_id="item-1">
            <.octicon name="typography-16" /><span>Text</span>
          </.action_list_item>
          <.action_list_item is_single_select is_selected input_id="item-2">
            <.octicon name="number-16" /><span>Number</span>
          </.action_list_item>
          <.action_list_item is_single_select input_id="item-3">
            <.octicon name="calendar-16" /><span>Calendar</span>
          </.action_list_item>
          <.action_list_item is_single_select input_id="item-4">
            <.octicon name="iterations-16" /><span>Iteration</span>
          </.action_list_item>
        </.action_list>
      </.action_menu>
      """,
      __ENV__
    )
  end

  test "Attribute: is_aligned_end" do
    assigns = %{}

    run_test(
      ~H"""
      <.action_menu is_aligned_end id="my-menu">
        <:toggle phx-click={toggle_menu("my-menu")}>
          Menu
        </:toggle>
        LIST
      </.action_menu>
      """,
      __ENV__
    )
  end

  test "Attribute: is_backdrop" do
    assigns = %{}

    run_test(
      ~H"""
      <.action_menu is_backdrop id="my-menu">
        <:toggle phx-click={toggle_menu("my-menu")}>
          Menu
        </:toggle>
        LIST
      </.action_menu>
      """,
      __ENV__
    )
  end

  test "Attribute: backdrop_strength" do
    assigns = %{}

    run_test(
      ~H"""
      <.action_menu is_backdrop backdrop_strength="strong" id="my-menu">
        <:toggle phx-click={toggle_menu("my-menu")}>
          Menu
        </:toggle>
        LIST
      </.action_menu>
      """,
      __ENV__
    )
  end

  test "Attribute: is_fast" do
    assigns = %{}

    run_test(
      ~H"""
      <.action_menu id="my-menu" is_fast={false}>
        <:toggle phx-click={toggle_menu("my-menu")}>
          Menu
        </:toggle>
        LIST
      </.action_menu>
      """,
      __ENV__
    )
  end

  test "Attribute: menu_theme" do
    assigns = %{
      theme_state: %{
        color_mode: "dark",
        light_theme: "light_colorblind",
        dark_theme: "dark_high_contrast"
      }
    }

    run_test(
      ~H"""
      <.action_menu is_aligned_end menu_theme={@theme_state} id="my-menu">
        <:toggle phx-click={toggle_menu("my-menu")}>
          Menu
        </:toggle>
        LIST
      </.action_menu>
      """,
      __ENV__
    )
  end

  test "Attribute: is_show_on_mount" do
    assigns = %{
      condition: true,
      equals_initial_condition: true
    }

    run_test(
      ~H"""
      <.action_menu :if={@condition} id="my-menu" is_show is_show_on_mount={@equals_initial_condition}>
        <:toggle phx-click={toggle_menu("my-menu")}>
          Menu
        </:toggle>
        LIST
      </.action_menu>
      """,
      __ENV__
    )
  end

  test "Attribute: classes" do
    assigns = %{}

    run_test(
      ~H"""
      <.action_menu
        is_dropdown_caret
        id="my-menu"
        classes={
          %{
            action_menu: "action_menu-x",
            caret: "caret-x",
            menu_container: "menu_container-x",
            menu_list: "menu_list-x",
            menu: "menu-x",
            toggle: "toggle-x"
          }
        }
        class="my-action-menu"
      >
        <:toggle phx-click={open_menu("my-menu")} class="my-toggle">
          Menu
        </:toggle>
        LIST
      </.action_menu>
      """,
      __ENV__
    )
  end
end
