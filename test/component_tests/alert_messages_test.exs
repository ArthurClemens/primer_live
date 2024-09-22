defmodule PrimerLive.TestComponents.AlertMessagesTest do
  @moduledoc false

  use PrimerLive.TestBase

  test "Content slot" do
    assigns = %{}

    run_test(
      ~H"""
      <.alert_messages>
        <.alert state="success">
          Message 1
        </.alert>
        <.alert class="mt-4">
          Message 2
        </.alert>
      </.alert_messages>
      Rest of content
      """,
      __ENV__
    )
  end

  test "Class" do
    assigns = %{}

    run_test(
      ~H"""
      <.alert_messages class="x">Messages</.alert_messages>
      """,
      __ENV__
    )
  end

  test "Extra attributes" do
    assigns = %{}

    run_test(
      ~H"""
      <.alert_messages dir="rtl">Messages</.alert_messages>
      """,
      __ENV__
    )
  end
end
