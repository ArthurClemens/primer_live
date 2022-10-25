defmodule PrimerLive.TestComponents.AlertTest do
  use ExUnit.Case
  use PrimerLive
  import PrimerLive.Helpers.TestHelpers

  import Phoenix.Component
  import Phoenix.LiveViewTest

  test "Without attributes or slots" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.alert>Message</.alert>
           """)
           |> format_html() ==
             """
             <div class="flash"> Message </div>
             """
             |> format_html()
  end

  test "Alert modifiers" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.alert is_error>Message</.alert>
           <.alert is_success>Message</.alert>
           <.alert is_warning>Message</.alert>
           <.alert is_full>Message</.alert>
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
    assigns = %{}

    assert rendered_to_string(~H"""
           <.alert class="alert-x" is_error>Message</.alert>
           """)
           |> format_html() ==
             """
             <div class="flash flash-error alert-x">Message</div>
             """
             |> format_html()
  end

  test "Extra attributes" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.alert dir="rtl">Message</.alert>
           """)
           |> format_html() ==
             """
             <div class="flash" dir="rtl"> Message </div>
             """
             |> format_html()
  end
end
