defmodule PrimerLive.TestComponents.BreadcrumbTest do
  @moduledoc false

  use PrimerLive.TestBase

  test "Slot: item" do
    assigns = %{}

    run_test(
      ~H"""
      <.breadcrumb>
        <:item href="/1">Item 1</:item>
        <:item href="/2">Item 2</:item>
        <:item href="/3">Last item</:item>
      </.breadcrumb>
      """,
      __ENV__
    )
  end

  test "Slot: item (single item)" do
    assigns = %{}

    run_test(
      ~H"""
      <.breadcrumb>
        <:item href="#url">First and last item</:item>
      </.breadcrumb>
      """,
      __ENV__
    )
  end

  test "Slot: item (with links)" do
    assigns = %{}

    run_test(
      ~H"""
      <.breadcrumb>
        <:item href="/home">Home</:item>
        <:item navigate="/account">Account</:item>
        <:item patch="/account/history">History</:item>
      </.breadcrumb>
      """,
      __ENV__
    )
  end

  test "Classes" do
    assigns = %{}

    run_test(
      ~H"""
      <.breadcrumb
        class="my-breadcrumb"
        classes={
          %{
            breadcrumb: "breadcrumb-x",
            item: "item-x",
            selected_item: "selected_item-x",
            link: "link-x"
          }
        }
      >
        <:item href="/1" class="my-link-1">Item 1</:item>
        <:item href="/2" class="my-link-2">Last item</:item>
      </.breadcrumb>
      """,
      __ENV__
    )
  end
end
