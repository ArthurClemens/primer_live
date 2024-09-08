defmodule PrimerLive.TestComponents.LabelTest do
  use ExUnit.Case
  use PrimerLive
  import PrimerLive.Helpers.TestHelpers

  import Phoenix.Component
  import Phoenix.LiveViewTest

  test "Regular label: lWithout attributes" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.label>Label</.label>
           """)
           |> format_html() ==
             """
             <span class="Label">Label</span>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end

  test "Regular label: Attributes" do
    assigns = %{}

    assert rendered_to_string(~H"""
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
           """)
           |> format_html() ==
             """
             <span class="Label Label--primary">Label</span>
             <span class="Label Label--secondary">Label</span>
             <span class="Label Label--accent">Label</span>
             <span class="Label Label--success">Label</span>
             <span class="Label Label--attention">Label</span>
             <span class="Label Label--severe">Label</span>
             <span class="Label Label--danger">Label</span>
             <span class="Label Label--open">Label</span>
             <span class="Label Label--closed">Label</span>
             <span class="Label Label--done">Label</span>
             <span class="Label Label--sponsors">Label</span>
             <span class="Label Label--large">Label</span>
             <span class="Label Label--inline">Label</span>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end

  test "Regular label: Attribute: class" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.label class="my-label">Label</.label>
           """)
           |> format_html() ==
             """
             <span class="Label my-label">Label</span>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end

  test "Regular label: Other attributes" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.label dir="rtl">Label</.label>
           """)
           |> format_html() ==
             """
             <span class="Label" dir="rtl">Label</span>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end

  test "Issue label: without attributes" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.issue_label>Label</.issue_label>
           """)
           |> format_html() ==
             """
             <span class="IssueLabel">Label</span>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end

  test "Issue label: Attribute: is_big" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.issue_label is_big>Label</.issue_label>
           """)
           |> format_html() ==
             """
             <span class="IssueLabel IssueLabel--big">Label</span>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end

  test "Issue label: Attribute: class" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.issue_label class="color-bg-accent-emphasis color-fg-on-emphasis">Label</.issue_label>
           """)
           |> format_html() ==
             """
             <span class="IssueLabel color-bg-accent-emphasis color-fg-on-emphasis">Label</span>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end

  test "Issue label:Other attributes" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.issue_label dir="rtl">Label</.issue_label>
           """)
           |> format_html() ==
             """
             <span class="IssueLabel" dir="rtl">Label</span>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end

  test "State label: without attributes" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.state_label>Label</.state_label>
           """)
           |> format_html() ==
             """
             <span class="State">Label</span>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end

  test "State label: Attributes" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.state_label is_small>Label</.state_label>
           <.state_label is_draft>Label</.state_label>
           <.state_label is_open>Label</.state_label>
           <.state_label is_merged>Label</.state_label>
           <.state_label is_closed>Label</.state_label>
           """)
           |> format_html() ==
             """
             <span class="State State--small">Label</span>
             <span class="State State--draft">Label</span>
             <span class="State State--open">Label</span>
             <span class="State State--merged">Label</span>
             <span class="State State--closed">Label</span>

             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end

  test "State label: Attribute: class" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.state_label class="color-bg-accent-emphasis color-fg-on-emphasis">Label</.state_label>
           """)
           |> format_html() ==
             """
             <span class="State color-bg-accent-emphasis color-fg-on-emphasis">Label</span>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end

  test "State label:Other attributes" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.state_label dir="rtl">Label</.state_label>
           """)
           |> format_html() ==
             """
             <span class="State" dir="rtl">Label</span>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end

  test "Counter label: without attributes" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.counter>12</.counter>
           """)
           |> format_html() ==
             """
             <span class="Counter">12</span>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end

  test "Counter label: Attributes" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.counter is_primary>12</.counter>
           <.counter is_secondary>12</.counter>
           """)
           |> format_html() ==
             """
             <span class="Counter Counter--primary">12</span>
             <span class="Counter Counter--secondary">12</span>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end

  test "Counter label: Attribute: class" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.counter class="color-bg-accent-emphasis color-fg-on-emphasis">12</.counter>
           """)
           |> format_html() ==
             """
             <span class="Counter color-bg-accent-emphasis color-fg-on-emphasis">12</span>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end

  test "Counter label:Other attributes" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.counter dir="rtl">12</.counter>
           """)
           |> format_html() ==
             """
             <span class="Counter" dir="rtl">12</span>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end
end
