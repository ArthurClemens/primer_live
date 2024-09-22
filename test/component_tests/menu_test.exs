defmodule PrimerLive.Components.MenuTest do
  @moduledoc false

  use PrimerLive.TestBase

  test "Slot: item links" do
    assigns = %{}

    run_test(
      ~H"""
      <.menu aria_label="Menu">
        <:item href="#url" is_selected>
          href link
        </:item>
        <:item navigate="#url">
          navigate link
        </:item>
        <:item patch="#url">
          patch link
        </:item>
        <:item>
          Other content
        </:item>
      </.menu>
      """,
      __ENV__
    )
  end

  test "Slot: item links (with various content)" do
    assigns = %{}

    run_test(
      ~H"""
      <.menu>
        <:item href="#url" is_selected>
          <.octicon name="comment-discussion-16" />
          <span>Conversation</span>
          <.counter>2</.counter>
        </:item>
        <:item href="#url">
          <.octicon name="check-circle-16" />
          <span>Done</span>
          <.counter>99</.counter>
        </:item>
      </.menu>
      """,
      __ENV__
    )
  end

  test "Slot: heading" do
    assigns = %{}

    run_test(
      ~H"""
      <.menu id="menu-yyy">
        <:item href="#url" is_selected>
          Link 1
        </:item>
        <:item href="#url">
          Link 2
        </:item>
        <:heading>Menu heading</:heading>
      </.menu>
      """,
      __ENV__
    )
  end

  test "Classes" do
    assigns = %{}

    run_test(
      ~H"""
      <.menu
        classes={
          %{
            menu: "menu-x",
            item: "item-x",
            heading: "heading-x"
          }
        }
        class="my-menu"
        id="menu-xxx"
      >
        <:item href="#url" is_selected class="my-item">
          One
        </:item>
        <:item href="#url">
          Two
        </:item>
        <:heading class="my-heading">
          Menu heading
        </:heading>
      </.menu>
      """,
      __ENV__
    )
  end

  test "Extra attributes" do
    assigns = %{}

    run_test(
      ~H"""
      <.menu dir="rtl" id="qqq">
        <:item href="#url" is_selected aria-label="View One">
          One
        </:item>
        <:item href="#url">
          Two
        </:item>
        <:heading aria-label="Heading">
          Menu heading
        </:heading>
      </.menu>
      """,
      __ENV__
    )
  end
end
