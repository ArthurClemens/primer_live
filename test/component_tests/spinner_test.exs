defmodule PrimerLive.Components.SpinnerTest do
  @moduledoc false

  use PrimerLive.TestBase

  test "Render component" do
    assigns = %{}

    run_test(
      ~H"""
      <.spinner />
      """,
      __ENV__
    )
  end

  test "Attribute: size" do
    assigns = %{}

    run_test(
      ~H"""
      <.spinner size="40" />
      <.spinner size={40} />
      """,
      __ENV__
    )
  end

  test "Attribute: color" do
    assigns = %{}

    run_test(
      ~H"""
      <.spinner color="red" />
      <.spinner color="#ff0000" />
      <.spinner color="rgba(250, 50, 150, 0.5)" />
      """,
      __ENV__
    )
  end

  test "Attribute: highlight_color" do
    assigns = %{}

    run_test(
      ~H"""
      <.spinner highlight_color="black" />
      <.spinner highlight_color="#000000" />
      <.spinner highlight_color="rgba(0, 0, 0, 1)" />
      """,
      __ENV__
    )
  end

  test "Attribute: gap_color (deprecated)" do
    assigns = %{}

    run_test(
      ~H"""
      <.spinner gap_color="black" />
      <.spinner gap_color="#000000" />
      <.spinner gap_color="rgba(0, 0, 0, 1)" />
      """,
      __ENV__
    )
  end

  test "Other attributes" do
    assigns = %{}

    run_test(
      ~H"""
      <.spinner class="my-spinner" dir="rtl" />
      """,
      __ENV__
    )
  end
end
