defmodule PrimerLive.TestComponents.AnimatedEllipsisTest do
  @moduledoc false

  use PrimerLive.TestBase

  test "Render component" do
    assigns = %{}

    run_test(
      ~H"""
      <.animated_ellipsis />
      """,
      __ENV__
    )
  end

  test "Other attributes" do
    assigns = %{}

    run_test(
      ~H"""
      <.animated_ellipsis class="x" dir="rtl" />
      """,
      __ENV__
    )
  end
end
