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
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end

  test "Alert modifiers" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.alert state="default">Message</.alert>
           <.alert state="info">Message</.alert>
           <.alert state="error">Message</.alert>
           <.alert state="success">Message</.alert>
           <.alert state="warning">Message</.alert>
           <.alert is_full>Message</.alert>
           """)
           |> format_html() ==
             """
             <div class="flash">Message</div>
             <div class="flash">Message</div>
             <div class="flash flash-error">Message</div>
             <div class="flash flash-success">Message</div>
             <div class="flash flash-warn">Message</div>
             <div class="flash flash-full">Message</div>
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
           <.alert class="alert-x" state="error">Message</.alert>
           """)
           |> format_html() ==
             """
             <div class="flash flash-error alert-x">Message</div>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
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

    assert rendered_to_string(~H"""
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
           """)
           |> format_html() ==
             """
             <div class="flash my-alert">Default (implicit)</div>
             <div class="flash default-x my-alert">Default (explicit)</div>
             <div class="flash info-x my-alert">Info</div>
             <div class="flash flash-success success-x my-alert">Success</div>
             <div class="flash flash-warn warning-x my-alert">Warning</div>
             <div class="flash flash-error error-x my-alert">Error</div>
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
           <.alert dir="rtl">Message</.alert>
           """)
           |> format_html() ==
             """
             <div class="flash" dir="rtl"> Message </div>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end
end
