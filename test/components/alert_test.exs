defmodule PrimerLive.Components.AlertTest do
  use ExUnit.Case
  use PrimerLive
  import PrimerLive.Helpers.TestHelpers

  import Phoenix.LiveView.Helpers
  import Phoenix.LiveViewTest

  test "Called without options or inner_block: should render an error message" do
    assigns = []

    assert rendered_to_string(~H"""
           <.alert />
           """)
           |> format_html() ==
             """
             <div class="flash flash-error"><p>alert component received invalid options:</p><p>inner_block: can&#39;t be blank</p></div>
             """
             |> format_html()
  end

  test "Called without options: should render the alert element" do
    assigns = []

    assert rendered_to_string(~H"""
           <.alert>Message</.alert>
           """)
           |> format_html() ==
             """
             <div class="flash"> Message </div>
             """
             |> format_html()
  end

  test "Option: is_error" do
    assigns = []

    assert rendered_to_string(~H"""
           <.alert is_error>Message</.alert>
           """)
           |> format_html() ==
             """
             <div class="flash flash-error">Message</div>
             """
             |> format_html()
  end

  test "Option: is_success" do
    assigns = []

    assert rendered_to_string(~H"""
           <.alert is_success>Message</.alert>
           """)
           |> format_html() ==
             """
             <div class="flash flash-success">Message</div>
             """
             |> format_html()
  end

  test "Option: is_warning" do
    assigns = []

    assert rendered_to_string(~H"""
           <.alert is_warning>Message</.alert>
           """)
           |> format_html() ==
             """
             <div class="flash flash-warn">Message</div>
             """
             |> format_html()
  end

  test "Option: is_full" do
    assigns = []

    assert rendered_to_string(~H"""
           <.alert is_full>Message</.alert>
           """)
           |> format_html() ==
             """
             <div class="flash flash-full">Message</div>
             """
             |> format_html()
  end

  test "Option: class" do
    assigns = []

    assert rendered_to_string(~H"""
           <.alert class="x">Message</.alert>
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
           <.alert dir="rtl">Message</.alert>
           """)
           |> format_html() ==
             """
             <div class="flash" dir="rtl"> Message </div>
             """
             |> format_html()
  end
end
