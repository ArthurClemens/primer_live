defmodule PrimerLive.TestComponents.BranchNameTest do
  @moduledoc false

  use PrimerLive.TestBase

  test "Inner block" do
    assigns = %{}

    run_test(
      ~H"""
      <.branch_name>
        some-name
      </.branch_name>
      """,
      __ENV__
    )
  end

  test "Link" do
    assigns = %{}

    run_test(
      ~H"""
      <.branch_name href="#url">
        href
      </.branch_name>
      <.branch_name navigate="#url">
        navigate
      </.branch_name>
      <.branch_name patch="#url">
        patch
      </.branch_name>
      """,
      __ENV__
    )
  end

  test "Icon" do
    assigns = %{}

    run_test(
      ~H"""
      <.branch_name class="my-branch-name">
        <.octicon name="git-branch-16" /> some-name
      </.branch_name>
      """,
      __ENV__
    )
  end

  test "Class" do
    assigns = %{}

    run_test(
      ~H"""
      <.branch_name class="my-branch-name">
        some-name
      </.branch_name>
      """,
      __ENV__
    )
  end

  test "Extra" do
    assigns = %{}

    run_test(
      ~H"""
      <.branch_name dir="rtl" aria-label="Current branch">
        some-name
      </.branch_name>
      """,
      __ENV__
    )
  end
end
