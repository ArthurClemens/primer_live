defmodule PrimerLive.Components.BlankslateTest do
  @moduledoc false

  use PrimerLive.TestBase

  test "Render component" do
    assigns = %{}

    run_test(
      ~H"""
      <.blankslate />
      """,
      __ENV__
    )
  end

  test "Slot: inner_block" do
    assigns = %{}

    run_test(
      ~H"""
      <.blankslate>
        <p>Use it to provide information when no dynamic content exists.</p>
      </.blankslate>
      """,
      __ENV__
    )
  end

  test "Slot: heading" do
    assigns = %{}

    run_test(
      ~H"""
      <.blankslate>
        <:heading>
          This is a blank slate
        </:heading>
      </.blankslate>
      """,
      __ENV__
    )
  end

  test "Slot: heading with attr tag" do
    assigns = %{}

    run_test(
      ~H"""
      <.blankslate>
        <:heading tag="h2">
          This is a blank slate
        </:heading>
      </.blankslate>
      """,
      __ENV__
    )
  end

  test "Slot: octicon" do
    assigns = %{}

    run_test(
      ~H"""
      <.blankslate>
        <:octicon name="rocket-24" />
      </.blankslate>
      """,
      __ENV__
    )
  end

  test "Slot: img" do
    assigns = %{}

    run_test(
      ~H"""
      <.blankslate>
        <:img src="https://ghicons.github.com/assets/images/blue/png/Pull%20request.png" alt="" />
      </.blankslate>
      """,
      __ENV__
    )
  end

  test "Slot: action" do
    assigns = %{}

    run_test(
      ~H"""
      <.blankslate>
        <:action>
          <.button is_primary>New project</.button>
        </:action>
        <:action>
          <.button is_link>Learn more</.button>
        </:action>
      </.blankslate>
      """,
      __ENV__
    )
  end

  test "Attributes" do
    assigns = %{}

    run_test(
      ~H"""
      <.blankslate is_narrow />
      <.blankslate is_large />
      <.blankslate is_spacious />
      """,
      __ENV__
    )
  end

  test "Classes" do
    assigns = %{}

    run_test(
      ~H"""
      <.blankslate
        class="my-blankslate"
        classes={
          %{
            blankslate: "blankslate-x",
            octicon: "octicon-x",
            img: "img-x",
            heading: "heading-x",
            action: "action-x"
          }
        }
      >
        <:heading class="my-heading">
          This is a blank slate
        </:heading>
        <:octicon name="rocket-24" class="my-octicon" />
        <:img
          src="https://ghicons.github.com/assets/images/blue/png/Pull%20request.png"
          alt=""
          class="my-img"
        />
        <:action class="my-action">
          <.button is_primary>New project</.button>
        </:action>
        <p>Use it to provide information when no dynamic content exists.</p>
      </.blankslate>
      """,
      __ENV__
    )
  end

  test "Attribute: style" do
    assigns = %{}

    run_test(
      ~H"""
      <.blankslate style="border: 1px solid red;" />
      """,
      __ENV__
    )
  end
end
