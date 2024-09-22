defmodule PrimerLive.TestComponents.CircleBadgeTest do
  @moduledoc false

  use PrimerLive.TestBase

  test "Slot: octicon" do
    assigns = %{}

    run_test(
      ~H"""
      <.circle_badge>
        <:octicon name="alert-16" />
      </.circle_badge>
      """,
      __ENV__
    )
  end

  test "Slot: img" do
    assigns = %{}

    run_test(
      ~H"""
      <.circle_badge>
        <:img src="https://github.com/travis-ci.png" alt="" />
      </.circle_badge>
      """,
      __ENV__
    )
  end

  test "Attribute: size (medium)" do
    assigns = %{}

    run_test(
      ~H"""
      <.circle_badge size="medium">
        <:octicon name="alert-16" />
      </.circle_badge>
      """,
      __ENV__
    )
  end

  test "Attribute: size (large)" do
    assigns = %{}

    run_test(
      ~H"""
      <.circle_badge size="large">
        <:octicon name="alert-16" />
      </.circle_badge>
      """,
      __ENV__
    )
  end

  test "Links" do
    assigns = %{}

    run_test(
      ~H"""
      <.circle_badge href="#url">
        <:octicon name="alert-16" />
      </.circle_badge>
      <.circle_badge navigate="#url">
        <:octicon name="alert-16" />
      </.circle_badge>
      <.circle_badge patch="#url">
        <:octicon name="alert-16" />
      </.circle_badge>
      """,
      __ENV__
    )
  end
end
