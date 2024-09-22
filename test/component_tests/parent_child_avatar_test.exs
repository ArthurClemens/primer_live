defmodule PrimerLive.TestComponents.ParentChildAvatarTest do
  @moduledoc false

  use PrimerLive.TestBase

  test "Parent and child slots" do
    assigns = %{}

    run_test(
      ~H"""
      <.parent_child_avatar>
        <:parent src="parent.jpg" size="7" />
        <:child src="child.jpg" size="2" />
      </.parent_child_avatar>
      """,
      __ENV__
    )
  end

  test "Classes" do
    assigns = %{}

    run_test(
      ~H"""
      <.parent_child_avatar class="my-parent-child">
        <:parent src="parent.jpg" size="7" class="my-parent" />
        <:child src="child.jpg" size="2" class="my-child" />
      </.parent_child_avatar>
      """,
      __ENV__
    )
  end
end
