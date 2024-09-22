defmodule PrimerLive.Components.SideNavTest do
  @moduledoc false

  use PrimerLive.TestBase

  test "Slot: item links" do
    assigns = %{}

    run_test(
      ~H"""
      <.side_nav aria_label="Menu">
        <:item href="#url" is_selected>
          href link
        </:item>
        <:item navigate="#url">
          navigate link
        </:item>
        <:item patch="#url">
          patch link
        </:item>
      </.side_nav>
      """,
      __ENV__
    )
  end

  test "Slot: item links (with various content)" do
    assigns = %{}

    run_test(
      ~H"""
      <.side_nav>
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
        <:item href="#url">
          <h5>With a heading</h5>
          <span>and some longer description</span>
        </:item>
      </.side_nav>
      """,
      __ENV__
    )
  end

  test "Sub navigation" do
    assigns = %{}

    run_test(
      ~H"""
      <.side_nav is_sub_nav>
        <:item href="#url" is_selected>
          Item 1
        </:item>
        <:item href="#url">
          Item 2
        </:item>
        <:item href="#url">
          Item 3
        </:item>
      </.side_nav>
      """,
      __ENV__
    )
  end

  test "Nested item" do
    assigns = %{}

    run_test(
      ~H"""
      <.side_nav>
        <:item href="#url" is_selected>
          Item 1
        </:item>
        <:item navigate="#url">
          Item 2
        </:item>
        <:item>
          <.side_nav is_sub_nav class="border-top py-3" style="padding-left: 16px">
            <:item href="#url" is_selected>
              Sub item 1
            </:item>
            <:item navigate="#url">
              Sub item 2
            </:item>
          </.side_nav>
        </:item>
        <:item navigate="#url">
          Item 3
        </:item>
      </.side_nav>
      """,
      __ENV__
    )
  end

  test "Attribute: is_border" do
    assigns = %{}

    run_test(
      ~H"""
      <.side_nav is_border>
        <:item href="#url" is_selected class="my-item">
          One
        </:item>
        <:item href="#url">
          Two
        </:item>
      </.side_nav>
      """,
      __ENV__
    )
  end

  test "Classes" do
    assigns = %{}

    run_test(
      ~H"""
      <.side_nav
        classes={
          %{
            side_nav: "side_nav-x",
            item: "item-x",
            sub_item: "sub-item-x"
          }
        }
        class="my-side_nav"
      >
        <:item href="#url" is_selected class="my-item">
          One
        </:item>
        <:item href="#url">
          Two
        </:item>
      </.side_nav>
      <.side_nav
        is_sub_nav
        classes={
          %{
            side_nav: "side_nav-x",
            item: "item-x",
            sub_item: "sub-item-x"
          }
        }
        class="my-side_nav"
      >
        <:item href="#url" is_selected class="my-item">
          One
        </:item>
        <:item href="#url">
          Two
        </:item>
      </.side_nav>
      """,
      __ENV__
    )
  end

  test "Extra attributes" do
    assigns = %{}

    run_test(
      ~H"""
      <.side_nav aria_label="Topics navigation" dir="rtl">
        <:item href="#url" is_selected aria-label="View One">
          One
        </:item>
        <:item href="#url">
          Two
        </:item>
      </.side_nav>
      """,
      __ENV__
    )
  end
end
