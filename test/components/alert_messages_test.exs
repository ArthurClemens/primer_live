defmodule PrimerLive.TestComponents.AlertMessagesTest do
  use ExUnit.Case
  use PrimerLive
  import PrimerLive.Helpers.TestHelpers

  import Phoenix.Component
  import Phoenix.LiveViewTest

  test "Content slot" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.alert_messages>
             <.alert state="success">
               Message 1
             </.alert>
             <.alert class="mt-4">
               Message 2
             </.alert>
           </.alert_messages>
           Rest of content
           """)
           |> format_html() ==
             """
             <div class="flash-messages">
             <div class="flash flash-success">Message 1</div>
             <div class="flash mt-4">Message 2</div>
             </div>
             Rest of content
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end

  test "Class" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.alert_messages class="x">Messages</.alert_messages>
           """)
           |> format_html() ==
             """
             <div class="flash-messages x">Messages</div>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end

  test "Extra attributes" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.alert_messages dir="rtl">Messages</.alert_messages>
           """)
           |> format_html() ==
             """
             <div class="flash-messages" dir="rtl"> Messages </div>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end
end
