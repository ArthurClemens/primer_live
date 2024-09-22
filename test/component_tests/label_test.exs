defmodule PrimerLive.TestComponents.LabelTest do
  @moduledoc false

  use PrimerLive.TestBase

  test "Regular label: lWithout attributes" do
    assigns = %{}

    run_test(
      ~H"""
      <.label>Label</.label>
      """,
      __ENV__
    )
  end

  test "Regular label: Attributes" do
    assigns = %{}

    run_test(
      ~H"""
      <.label is_primary>Label</.label>
      <.label is_secondary>Label</.label>
      <.label is_accent>Label</.label>
      <.label is_success>Label</.label>
      <.label is_attention>Label</.label>
      <.label is_severe>Label</.label>
      <.label is_danger>Label</.label>
      <.label is_open>Label</.label>
      <.label is_closed>Label</.label>
      <.label is_done>Label</.label>
      <.label is_sponsors>Label</.label>
      <.label is_large>Label</.label>
      <.label is_inline>Label</.label>
      """,
      __ENV__
    )
  end

  test "Regular label: Attribute: class" do
    assigns = %{}

    run_test(
      ~H"""
      <.label class="my-label">Label</.label>
      """,
      __ENV__
    )
  end

  test "Regular label: Other attributes" do
    assigns = %{}

    run_test(
      ~H"""
      <.label dir="rtl">Label</.label>
      """,
      __ENV__
    )
  end

  test "Issue label: without attributes" do
    assigns = %{}

    run_test(
      ~H"""
      <.issue_label>Label</.issue_label>
      """,
      __ENV__
    )
  end

  test "Issue label: Attribute: is_big" do
    assigns = %{}

    run_test(
      ~H"""
      <.issue_label is_big>Label</.issue_label>
      """,
      __ENV__
    )
  end

  test "Issue label: Attribute: class" do
    assigns = %{}

    run_test(
      ~H"""
      <.issue_label class="color-bg-accent-emphasis color-fg-on-emphasis">Label</.issue_label>
      """,
      __ENV__
    )
  end

  test "Issue label:Other attributes" do
    assigns = %{}

    run_test(
      ~H"""
      <.issue_label dir="rtl">Label</.issue_label>
      """,
      __ENV__
    )
  end

  test "State label: without attributes" do
    assigns = %{}

    run_test(
      ~H"""
      <.state_label>Label</.state_label>
      """,
      __ENV__
    )
  end

  test "State label: Attributes" do
    assigns = %{}

    run_test(
      ~H"""
      <.state_label is_small>Label</.state_label>
      <.state_label is_draft>Label</.state_label>
      <.state_label is_open>Label</.state_label>
      <.state_label is_merged>Label</.state_label>
      <.state_label is_closed>Label</.state_label>
      """,
      __ENV__
    )
  end

  test "State label: Attribute: class" do
    assigns = %{}

    run_test(
      ~H"""
      <.state_label class="color-bg-accent-emphasis color-fg-on-emphasis">Label</.state_label>
      """,
      __ENV__
    )
  end

  test "State label:Other attributes" do
    assigns = %{}

    run_test(
      ~H"""
      <.state_label dir="rtl">Label</.state_label>
      """,
      __ENV__
    )
  end

  test "Counter label: without attributes" do
    assigns = %{}

    run_test(
      ~H"""
      <.counter>12</.counter>
      """,
      __ENV__
    )
  end

  test "Counter label: Attributes" do
    assigns = %{}

    run_test(
      ~H"""
      <.counter is_primary>12</.counter>
      <.counter is_secondary>12</.counter>
      """,
      __ENV__
    )
  end

  test "Counter label: Attribute: class" do
    assigns = %{}

    run_test(
      ~H"""
      <.counter class="color-bg-accent-emphasis color-fg-on-emphasis">12</.counter>
      """,
      __ENV__
    )
  end

  test "Counter label:Other attributes" do
    assigns = %{}

    run_test(
      ~H"""
      <.counter dir="rtl">12</.counter>
      """,
      __ENV__
    )
  end
end
