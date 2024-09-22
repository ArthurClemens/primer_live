defmodule PrimerLive.TestComponents.ProgressTest do
  @moduledoc false

  use PrimerLive.TestBase

  test "Default settings" do
    assigns = %{}

    run_test(
      ~H"""
      <.progress>
        <:item></:item>
      </.progress>
      """,
      __ENV__
    )
  end

  test "Attribute: width" do
    assigns = %{}

    run_test(
      ~H"""
      <.progress>
        <:item width="50"></:item>
      </.progress>
      <.progress>
        <:item width={50}></:item>
      </.progress>
      """,
      __ENV__
    )
  end

  test "Attribute: aria_label" do
    assigns = %{}

    run_test(
      ~H"""
      <.progress aria_label="5 tasks completed">
        <:item width="50"></:item>
      </.progress>
      """,
      __ENV__
    )
  end

  test "Attribute: state" do
    assigns = %{}

    run_test(
      ~H"""
      <div>
        <.progress>
          <:item width="50"></:item>
        </.progress>
      </div>
      <div>
        <.progress>
          <:item width="50" state="success"></:item>
        </.progress>
      </div>
      <div>
        <.progress>
          <:item width="50" state="info"></:item>
        </.progress>
      </div>
      <div>
        <.progress>
          <:item width="50" state="warning"></:item>
        </.progress>
      </div>
      <div>
        <.progress>
          <:item width="50" state="error"></:item>
        </.progress>
      </div>
      """,
      __ENV__
    )
  end

  test "Multiple bars" do
    assigns = %{}

    run_test(
      ~H"""
      <.progress>
        <:item width="50" state="success"></:item>
        <:item width="30" state="warning"></:item>
        <:item width="10" state="error"></:item>
        <:item width="5" state="info"></:item>
      </.progress>
      """,
      __ENV__
    )
  end

  test "Attribute: is_large, is_small, is_inline" do
    assigns = %{}

    run_test(
      ~H"""
      <div class="my-3">
        <.progress is_large>
          <:item width="50"></:item>
        </.progress>
      </div>
      <div class="my-3">
        <.progress is_small>
          <:item width="50"></:item>
        </.progress>
      </div>
      <div class="my-3">
        <.progress is_inline style="width: 160px;">
          <:item width="50"></:item>
        </.progress>
      </div>
      """,
      __ENV__
    )
  end

  test "Extra attribute: style" do
    assigns = %{}

    run_test(
      ~H"""
      <.progress>
        <:item width="50" style="height: 10px"></:item>
      </.progress>
      """,
      __ENV__
    )
  end

  test "Classes" do
    assigns = %{}

    run_test(
      ~H"""
      <.progress
        classes={
          %{
            progress: "progress-x",
            item: "item-x",
            state_success: "success-x",
            state_info: "info-x",
            state_warning: "warning-x",
            state_error: "error-x"
          }
        }
        class="my-progress"
      >
        <:item class="my-item"></:item>
        <:item width="40" state="success"></:item>
        <:item width="30" state="warning"></:item>
        <:item width="10" state="error"></:item>
        <:item width="5" state="info"></:item>
      </.progress>
      """,
      __ENV__
    )
  end
end
