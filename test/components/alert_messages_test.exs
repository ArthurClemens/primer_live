defmodule PrimerLive.Components.AlertMessagesTest do
  use ExUnit.Case
  use PrimerLive
  import PrimerLive.Helpers.TestHelpers

  import Phoenix.LiveView.Helpers
  import Phoenix.LiveViewTest

  test "Called without options or inner_block: should render an error message" do
    assigns = []

    assert rendered_to_string(~H"""
           <.alert_messages />
           """)
           |> format_html() ==
             """
             <div class="flash flash-error"><p>alert_messages component received invalid options:</p><p>inner_block: can&#39;t be blank</p></div>
             """
             |> format_html()
  end

  test "Called without options: should render the alert_messages item" do
    assigns = []

    assert rendered_to_string(~H"""
           <.alert_messages>
             <.alert is_success>
               <p>You're done!</p>
             </.alert>
           </.alert_messages>
           <.alert_messages>
             <.alert>
               <p>You may close this message</p>
             </.alert>
           </.alert_messages>
           """)
           |> format_html() ==
             """
             <div class="flash-messages">
             <div class="flash flash-success">
             <p>You're done!</p>
             </div>
             </div>
             <div class="flash-messages">
             <div class="flash">
             <p>You may close this message</p>
             </div>
             </div>
             """
             |> format_html()
  end

  test "Option: class" do
    assigns = []

    assert rendered_to_string(~H"""
           <.alert_messages class="x">Messages</.alert_messages>
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
           <.alert_messages dir="rtl">Messages</.alert_messages>
           """)
           |> format_html() ==
             """
             <div class="flash-messages" dir="rtl"> Messages </div>
             """
             |> format_html()
  end
end
