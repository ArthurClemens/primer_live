defmodule PrimerLive.TestComponents.AlertMessagesTest do
  use ExUnit.Case
  use PrimerLive
  import PrimerLive.Helpers.TestHelpers

  import Phoenix.Component
  import Phoenix.LiveViewTest

  test "Content slot" do
    assigns = []

    assert rendered_to_string(~H"""
           <.test_alert_messages>
             <.test_alert is_success>
               Message 1
             </.test_alert>
             <.test_alert class="mt-4">
               Message 2
             </.test_alert>
           </.test_alert_messages>
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
  end

  test "Class" do
    assigns = []

    assert rendered_to_string(~H"""
           <.test_alert_messages class="x">Messages</.test_alert_messages>
           """)
           |> format_html() ==
             """
             <div class="flash-messages x">Messages</div>
             """
             |> format_html()
  end

  test "Extra attributes" do
    assigns = []

    assert rendered_to_string(~H"""
           <.test_alert_messages dir="rtl">Messages</.test_alert_messages>
           """)
           |> format_html() ==
             """
             <div class="flash-messages" dir="rtl"> Messages </div>
             """
             |> format_html()
  end
end
