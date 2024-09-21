defmodule PrimerLive.Components.FilterListTest do
  @moduledoc false

  use PrimerLive.TestBase

  test "Slot: item links" do
    assigns = %{}

    run_test(
      ~H"""
      <.filter_list aria_label="Menu">
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
      </.filter_list>
      """,
      __ENV__
    )
  end

  test "Slot: item links with counts" do
    assigns = %{}

    run_test(
      ~H"""
      <.filter_list aria_label="Menu">
        <:item href="#url" is_selected count="99">
          First filter
        </:item>
        <:item href="#url" count={3}>
          Second filter
        </:item>
        <:item href="#url">
          Third filter
        </:item>
      </.filter_list>
      """,
      __ENV__
    )
  end

  test "Classes" do
    assigns = %{}

    run_test(
      ~H"""
      <.filter_list
        aria_label="Menu"
        classes={
          %{
            filter_list: "filter_list-x",
            item: "item-x",
            count: "count-x"
          }
        }
        class="my-filter-list"
      >
        <:item href="#url" is_selected count="99" class="my-item">
          First filter
        </:item>
        <:item href="#url" count={3}>
          Second filter
        </:item>
        <:item href="#url">
          Third filter
        </:item>
      </.filter_list>
      """,
      __ENV__
    )
  end

  test "Extra attributes" do
    assigns = %{}

    run_test(
      ~H"""
      <.filter_list aria_label="Menu" dir="rtl">
        <:item href="#url" is_selected aria-label="Item">
          href link
        </:item>
      </.filter_list>
      """,
      __ENV__
    )
  end
end
