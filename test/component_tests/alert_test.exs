defmodule PrimerLive.TestComponents.AlertTest do
  @moduledoc false

  use PrimerLive.TestBase

  test "Without attributes or slots" do
    assigns = %{}

    run_test(
      ~H"""
      <.alert>Message</.alert>
      """,
      __ENV__
    )
  end

  test "Alert modifiers" do
    assigns = %{}

    run_test(
      ~H"""
      <.alert state="default">Message</.alert>
      <.alert state="info">Message</.alert>
      <.alert state="error">Message</.alert>
      <.alert state="success">Message</.alert>
      <.alert state="warning">Message</.alert>
      <.alert is_full>Message</.alert>
      """,
      __ENV__
    )
  end

  test "Class" do
    assigns = %{}

    run_test(
      ~H"""
      <.alert class="alert-x" state="error">Message</.alert>
      """,
      __ENV__
    )
  end

  test "Classes" do
    classes = %{
      state_default: "default-x",
      state_info: "info-x",
      state_success: "success-x",
      state_warning: "warning-x",
      state_error: "error-x"
    }

    assigns = %{
      classes: classes
    }

    run_test(
      ~H"""
      <.alert classes={@classes} class="my-alert">
        Default (implicit)
      </.alert>
      <.alert classes={@classes} class="my-alert" state="default">
        Default (explicit)
      </.alert>
      <.alert classes={@classes} class="my-alert" state="info">
        Info
      </.alert>
      <.alert classes={@classes} class="my-alert" state="success">
        Success
      </.alert>
      <.alert classes={@classes} class="my-alert" state="warning">
        Warning
      </.alert>
      <.alert classes={@classes} class="my-alert" state="error">
        Error
      </.alert>
      """,
      __ENV__
    )
  end

  test "Extra attributes" do
    assigns = %{}

    run_test(
      ~H"""
      <.alert dir="rtl">Message</.alert>
      """,
      __ENV__
    )
  end
end
