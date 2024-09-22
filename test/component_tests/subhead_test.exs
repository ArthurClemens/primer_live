defmodule PrimerLive.TestComponents.SubheadTest do
  @moduledoc false

  use PrimerLive.TestBase

  test "Without attributes or slots" do
    assigns = %{}

    run_test(
      ~H"""
      <.subhead>Heading</.subhead>
      """,
      __ENV__
    )
  end

  test "Attributes: is_spacious" do
    assigns = %{}

    run_test(
      ~H"""
      <.subhead is_spacious>Heading</.subhead>
      """,
      __ENV__
    )
  end

  test "Attributes: is_danger" do
    assigns = %{}

    run_test(
      ~H"""
      <.subhead is_danger>Heading</.subhead>
      """,
      __ENV__
    )
  end

  test "Slot: description" do
    assigns = %{}

    run_test(
      ~H"""
      <.subhead>
        Heading
        <:description>
          Description
        </:description>
      </.subhead>
      """,
      __ENV__
    )
  end

  test "Slot: actions" do
    assigns = %{}

    run_test(
      ~H"""
      <.subhead>
        Heading
        <:actions>
          <.button is_primary>Action</.button>
        </:actions>
      </.subhead>
      """,
      __ENV__
    )
  end

  test "Classes" do
    assigns = %{}

    run_test(
      ~H"""
      <.subhead
        class="my-subhead"
        classes={
          %{
            subhead: "subhead-x",
            heading: "heading-x",
            description: "description-x",
            actions: "actions-x"
          }
        }
      >
        Heading
        <:actions class="my-action">
          <.button is_primary>Action</.button>
        </:actions>
        <:description class="my-description">
          Description
        </:description>
      </.subhead>
      """,
      __ENV__
    )
  end
end
