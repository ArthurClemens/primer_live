defmodule PrimerLive.TestComponents.ActionListItemTest do
  @moduledoc false

  use PrimerLive.TestBase

  test "Slot: inner_block" do
    assigns = %{}

    run_test(
      ~H"""
      <ul>
        <.action_list_item>
          Content
        </.action_list_item>
      </ul>
      """,
      __ENV__
    )
  end

  test "Slot: link" do
    assigns = %{}

    run_test(
      ~H"""
      <ul>
        <.action_list_item is_selected>
          <:link href="/url" target="_blank">
            href link
          </:link>
        </.action_list_item>
        <.action_list_item>
          <:link navigate="/url">
            navigate link
          </:link>
        </.action_list_item>
        <.action_list_item>
          <:link patch="/url">
            patch link
          </:link>
        </.action_list_item>
      </ul>
      """,
      __ENV__
    )
  end

  test "Link attributes (anchor links)" do
    assigns = %{}

    run_test(
      ~H"""
      <ul>
        <.action_list_item is_selected>
          <:link href="#url">
            href link
          </:link>
        </.action_list_item>
        <.action_list_item>
          <:link navigate="#url">
            navigate link
          </:link>
        </.action_list_item>
        <.action_list_item>
          <:link patch="#url">
            patch link
          </:link>
        </.action_list_item>
      </ul>
      """,
      __ENV__
    )
  end

  test "Attribute: is_button" do
    assigns = %{}

    run_test(
      ~H"""
      <ul>
        <.action_list_item is_button phx-click="remove">
          Button
        </.action_list_item>
      </ul>
      """,
      __ENV__
    )
  end

  test "Attribute: is_selected" do
    assigns = %{}

    run_test(
      ~H"""
      <ul>
        <.action_list_item is_selected>
          <:link href="/url">
            Item
          </:link>
        </.action_list_item>
        <.action_list_item is_selected>
          Item
        </.action_list_item>
      </ul>
      """,
      __ENV__
    )
  end

  test "Attributes: is_danger, is_disabled, is_truncated" do
    assigns = %{}

    run_test(
      ~H"""
      <ul>
        <.action_list_item is_danger>
          Item
        </.action_list_item>
        <.action_list_item is_disabled>
          Item
        </.action_list_item>
        <.action_list_item is_truncated>
          Very long label
        </.action_list_item>
      </ul>
      """,
      __ENV__
    )
  end

  test "Attribute: is_single_select" do
    assigns = %{}

    run_test(
      ~H"""
      <ul>
        <.action_list_item is_single_select is_selected input_id="item-1">
          Item
        </.action_list_item>
        <.action_list_item is_single_select input_id="item-2">
          Item
        </.action_list_item>
      </ul>
      """,
      __ENV__
    )
  end

  test "Attribute: is_single_select (custom visual)" do
    assigns = %{}

    run_test(
      ~H"""
      <ul>
        <.action_list_item is_single_select is_selected input_id="item-1">
          Item
          <:leading_visual>
            <.octicon name="bell-16" />
          </:leading_visual>
        </.action_list_item>
        <.action_list_item is_single_select input_id="item-2">
          Item
          <:leading_visual>
            <.octicon name="bell-16" />
          </:leading_visual>
        </.action_list_item>
      </ul>
      """,
      __ENV__
    )
  end

  test "Attribute: is_multiple_select" do
    assigns = %{}

    run_test(
      ~H"""
      <ul>
        <.action_list_item is_multiple_select is_selected input_id="item-1">
          Item
        </.action_list_item>
        <.action_list_item is_multiple_select input_id="item-2">
          Item
        </.action_list_item>
      </ul>
      """,
      __ENV__
    )
  end

  test "Attribute: is_multiple_select (custom visual)" do
    assigns = %{}

    run_test(
      ~H"""
      <ul>
        <.action_list_item is_multiple_select is_selected input_id="item-1">
          Item
          <:leading_visual>
            <.octicon name="bell-16" />
          </:leading_visual>
        </.action_list_item>
        <.action_list_item is_multiple_select input_id="item-2">
          Item
          <:leading_visual>
            <.octicon name="bell-16" />
          </:leading_visual>
        </.action_list_item>
      </ul>
      """,
      __ENV__
    )
  end

  test "Attribute: is_multiple_select with is_checkmark_icon" do
    assigns = %{}

    run_test(
      ~H"""
      <ul>
        <.action_list_item is_multiple_select is_checkmark_icon is_selected input_id="item-1">
          Item
          <:leading_visual>
            <.octicon name="bell-16" />
          </:leading_visual>
        </.action_list_item>
        <.action_list_item is_multiple_select is_checkmark_icon input_id="item-2">
          Item
          <:leading_visual>
            <.octicon name="bell-16" />
          </:leading_visual>
        </.action_list_item>
      </ul>
      """,
      __ENV__
    )
  end

  test "Attribute: is_collapsible, is_expanded" do
    assigns = %{}

    run_test(
      ~H"""
      <ul>
        <.action_list_item is_collapsible is_expanded>
          Item
        </.action_list_item>
        <.action_list_item is_collapsible>
          Item
        </.action_list_item>
      </ul>
      """,
      __ENV__
    )
  end

  test "Attribute: is_collapsible, is_expanded (custom visual)" do
    assigns = %{}

    run_test(
      ~H"""
      <ul>
        <.action_list_item is_collapsible is_expanded>
          Item
          <:trailing_visual>
            <.octicon name="bell-16" />
          </:trailing_visual>
        </.action_list_item>
        <.action_list_item is_collapsible>
          Item
          <:trailing_visual>
            <.octicon name="bell-16" />
          </:trailing_visual>
        </.action_list_item>
      </ul>
      """,
      __ENV__
    )
  end

  test "Sizes" do
    assigns = %{}

    run_test(
      ~H"""
      <ul>
        <.action_list_item>
          regular
        </.action_list_item>
        <.action_list_item is_height_medium>
          medium
        </.action_list_item>
        <.action_list_item is_height_large>
          large
        </.action_list_item>
      </ul>
      """,
      __ENV__
    )
  end

  test "Slot: description" do
    assigns = %{}

    run_test(
      ~H"""
      <ul>
        <.action_list_item>
          Content
          <:description>
            A descriptive text
          </:description>
        </.action_list_item>
      </ul>
      """,
      __ENV__
    )
  end

  test "Slot: description, attr is_inline_description" do
    assigns = %{}

    run_test(
      ~H"""
      <ul>
        <.action_list_item is_inline_description>
          Content
          <:description>
            A descriptive text
          </:description>
        </.action_list_item>
      </ul>
      """,
      __ENV__
    )
  end

  test "Slots: leading_visual and trailing_visual" do
    assigns = %{}

    run_test(
      ~H"""
      <ul>
        <.action_list_item>
          Item
          <:leading_visual>
            <.octicon name="bell-16" />
          </:leading_visual>
          <:trailing_visual>
            <.octicon name="bell-16" />
          </:trailing_visual>
        </.action_list_item>
      </ul>
      """,
      __ENV__
    )
  end

  test "Slot: sub_group" do
    assigns = %{}

    run_test(
      ~H"""
      <ul>
        <.action_list_section_divider>
          <:title id="title-01">Section title</:title>
        </.action_list_section_divider>
        <.action_list_item>
          Not collapsible item, default expanded
          <:sub_group aria-labelledby="title-01">
            <.action_list_item is_sub_item>
              Sub item
            </.action_list_item>
            <.action_list_item is_sub_item>
              Sub item
            </.action_list_item>
          </:sub_group>
        </.action_list_item>
        <.action_list_section_divider>
          <:title>Section title</:title>
        </.action_list_section_divider>
        <.action_list_item leading_visual_width="16" is_collapsible>
          Collapsible, not expanded item
          <:leading_visual>
            <.octicon name="comment-discussion-16" />
          </:leading_visual>
          <:sub_group>
            <.action_list_item is_sub_item>
              Sub item
            </.action_list_item>
            <.action_list_item is_sub_item>
              Sub item
            </.action_list_item>
          </:sub_group>
        </.action_list_item>
        <.action_list_section_divider>
          <:title>Section title</:title>
        </.action_list_section_divider>
        <.action_list_item leading_visual_width="16" is_collapsible is_expanded>
          Collapsible and expanded item
          <:leading_visual>
            <.octicon name="comment-discussion-16" />
          </:leading_visual>
          <:sub_group>
            <.action_list_item is_sub_item>
              Sub item
            </.action_list_item>
            <.action_list_item is_sub_item>
              Sub item
            </.action_list_item>
          </:sub_group>
        </.action_list_item>
        <.action_list_section_divider>
          <:title>Section title</:title>
        </.action_list_section_divider>
        <.action_list_item leading_visual_width="24" is_collapsible is_expanded>
          Collapsible and expanded item, wide visual
          <:leading_visual>
            <.octicon name="comment-discussion-24" />
          </:leading_visual>
          <:sub_group>
            <.action_list_item is_sub_item>
              Sub item
            </.action_list_item>
            <.action_list_item is_sub_item>
              Sub item
            </.action_list_item>
          </:sub_group>
        </.action_list_item>
      </ul>
      """,
      __ENV__
    )
  end

  test "Classes" do
    assigns = %{}

    run_test(
      ~H"""
      <ul>
        <.action_list_item
          classes={
            %{
              action_list_item: "action_list_item-x",
              content: "content-x",
              label: "label-x",
              description: "description-x",
              description_container: "description_container-x",
              leading_visual: "leading_visual-x",
              trailing_visual: "trailing_visual-x",
              sub_group: "sub_group-x"
            }
          }
          class="my-action-list-item"
        >
          <:link href="/url" class="my-link">
            Content
          </:link>
          <:description>
            A descriptive text
          </:description>
          <:leading_visual>
            <.octicon name="bell-16" />
          </:leading_visual>
          <:trailing_visual>
            <.octicon name="bell-16" />
          </:trailing_visual>
          <:sub_group class="my-sub-group">
            <.action_list_item is_sub_item class="my-sub-item">
              Sub item
            </.action_list_item>
          </:sub_group>
        </.action_list_item>
      </ul>
      """,
      __ENV__
    )
  end
end
