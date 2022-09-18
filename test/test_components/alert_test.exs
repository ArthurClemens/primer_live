defmodule PrimerLive.TestComponents.AlertTest do
  use ExUnit.Case
  use PrimerLive
  import PrimerLive.Helpers.TestHelpers

  import Phoenix.Component
  import Phoenix.LiveViewTest

  test "Without attributes or slots" do
    assigns = []

    assert rendered_to_string(~H"""
           <.test_alert>Message</.test_alert>
           """)
           |> format_html() ==
             """
             <div class="flash"> Message </div>
             """
             |> format_html()
  end

  test "Alert modifiers" do
    assigns = []

    assert rendered_to_string(~H"""
           <.test_alert is_error>Message</.test_alert>
           <.test_alert is_success>Message</.test_alert>
           <.test_alert is_warning>Message</.test_alert>
           <.test_alert is_full>Message</.test_alert>
           """)
           |> format_html() ==
             """
             <div class="flash flash-error">Message</div>
             <div class="flash flash-success">Message</div>
             <div class="flash flash-warn">Message</div>
             <div class="flash flash-full">Message</div>
             """
             |> format_html()
  end

  test "Class" do
    assigns = []

    assert rendered_to_string(~H"""
           <.test_alert class="x">Message</.test_alert>
           """)
           |> format_html() ==
             """
             <div class="flash x">Message</div>
             """
             |> format_html()
  end

  test "Extra attributes" do
    assigns = []

    assert rendered_to_string(~H"""
           <.test_alert dir="rtl">Message</.test_alert>
           """)
           |> format_html() ==
             """
             <div class="flash" dir="rtl"> Message </div>
             """
             |> format_html()
  end
end
