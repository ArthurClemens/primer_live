defmodule PrimerLive.TestComponents.OcticonTest do
  @moduledoc false

  use PrimerLive.TestBase

  test "With a correct name: should render the icon" do
    assigns = %{}

    run_test(
      ~H"""
      <.octicon name="alert-16" />
      """,
      __ENV__
    )
  end

  test "With an incorrect name: should render an error message" do
    assigns = %{}

    run_test(
      ~H"""
      <.octicon name="x" />
      """,
      __ENV__
    )
  end

  test "Attribute: class" do
    assigns = %{}

    run_test(
      ~H"""
      <.octicon name="alert-16" class="x" />
      """,
      __ENV__
    )
  end

  test "Extra attributes" do
    assigns = %{}

    run_test(
      ~H"""
      <.octicon name="alert-16" dir="rtl" />
      """,
      __ENV__
    )
  end
end
