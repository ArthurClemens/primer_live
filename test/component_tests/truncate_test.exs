defmodule PrimerLive.Components.TruncateTest do
  @moduledoc false

  use PrimerLive.TestBase

  test "Slot: text" do
    assigns = %{}

    run_test(
      ~H"""
      <.truncate>
        <:item>
          really-long-text
        </:item>
      </.truncate>
      """,
      __ENV__
    )
  end

  test "Custom tags" do
    assigns = %{}

    run_test(
      ~H"""
      <.truncate tag="ol">
        <:item tag="li">
          really-long-text
        </:item>
        <:item tag="li">
          really-long-text
        </:item>
      </.truncate>
      """,
      __ENV__
    )
  end

  test "Links" do
    assigns = %{}

    run_test(
      ~H"""
      <.truncate>
        <:item href="/">
          branch-name
        </:item>
        <:item navigate="/">
          branch-name
        </:item>
        <:item patch="/">
          branch-name
        </:item>
      </.truncate>
      """,
      __ENV__
    )
  end

  test "Slot: text, attribute is_primary" do
    assigns = %{}

    run_test(
      ~H"""
      <.truncate>
        <:item>
          really-long-text
        </:item>
        <:item is_primary>
          <span class="text-normal">/</span> really-long-repository-name
        </:item>
      </.truncate>
      """,
      __ENV__
    )
  end

  test "Slot: text, attribute is_expandable" do
    assigns = %{}

    run_test(
      ~H"""
      <.truncate>
        <:item tag="a" is_expandable>
          really-long-text
        </:item>
        <:item tag="a" is_expandable>
          really-long-text
        </:item>
      </.truncate>
      """,
      __ENV__
    )
  end

  test "Classes" do
    assigns = %{}

    run_test(
      ~H"""
      <.truncate
        class="my-truncate"
        classes={
          %{
            truncate: "truncate-x",
            item: "item-x"
          }
        }
      >
        <:item tag="a" class="my-item">
          really-long-text
        </:item>
      </.truncate>
      """,
      __ENV__
    )
  end

  test "Attribute: style" do
    assigns = %{}

    # Assert with rendered fragments because .dynamic_tag shuffles the order of attributes
    result =
      rendered_to_string(~H"""
      <.truncate>
        <:item is_expandable style="max-width: 300px;">
          really-long-text
        </:item>
      </.truncate>
      """)
      |> format_html()

    assert String.contains?(result, "<span class=\"Truncate\">")
    assert String.contains?(result, "style=\"max-width: 300px;\"")
    assert String.contains?(result, "class=\"Truncate-text Truncate-text--expandable\"")
  end
end
