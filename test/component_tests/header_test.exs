defmodule PrimerLive.TestComponents.HeaderTest do
  @moduledoc false

  use PrimerLive.TestBase

  test "Without attributes or slots, ignores any other content" do
    assigns = %{}

    run_test(
      ~H"""
      <.header>
        Content
      </.header>
      """,
      __ENV__
    )
  end

  test "Slot: item" do
    assigns = %{}

    run_test(
      ~H"""
      <.header>
        <:item>Item 1</:item>
        <:item>Item 2</:item>
        <:item>Item 3</:item>
      </.header>
      """,
      __ENV__
    )
  end

  test "Slot: item with attribute is_full" do
    assigns = %{}

    run_test(
      ~H"""
      <.header>
        <:item is_full>Item</:item>
      </.header>
      """,
      __ENV__
    )
  end

  test "Slot: item with links" do
    assigns = %{}

    run_test(
      ~H"""
      <.header>
        <:item :let={classes}>
          <.link href="/" class={classes.link}>Regular anchor link</.link>
        </:item>
        <:item :let={classes}>
          <.link navigate="/" class={[classes.link, "underline"]}>Home</.link>
        </:item>
      </.header>
      """,
      __ENV__
    )
  end

  test "Slot: item with input" do
    assigns = %{}

    run_test(
      ~H"""
      <.header>
        <:item :let={classes}>
          <.text_input form={:user} field={:first_name} type="search" class={classes.input} />
        </:item>
      </.header>
      """,
      __ENV__
    )
  end

  test "Attribute: variant" do
    assigns = %{}

    run_test(
      ~H"""
      <.header variant="base">
        Content
      </.header>
      """,
      __ENV__
    )
  end

  test "Attribute: is_compact" do
    assigns = %{}

    run_test(
      ~H"""
      <.header is_compact>
        Content
      </.header>
      """,
      __ENV__
    )
  end

  test "Attribute: classes" do
    assigns = %{}

    run_test(
      ~H"""
      <.header
        class="my-header"
        classes={
          %{
            header: "header-x",
            item: "item-x",
            link: "link-x"
          }
        }
      >
        <:item class="my-item">Item</:item>
        <:item is_full>Full item</:item>
        <:item :let={classes}>
          <.link navigate="/" class={[classes.link, "underline"]}>Home</.link>
        </:item>
      </.header>
      """,
      __ENV__
    )
  end

  test "Extra attributes" do
    assigns = %{}

    run_test(
      ~H"""
      <.header dir="rtl">
        <:item aria-disabled="true">Item</:item>
      </.header>
      """,
      __ENV__
    )
  end
end
