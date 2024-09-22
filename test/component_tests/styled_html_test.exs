defmodule PrimerLive.TestComponents.StyledHtmlTest do
  @moduledoc false

  use PrimerLive.TestBase

  test "Render content" do
    assigns = %{}

    run_test(
      ~H"""
      <.styled_html>
        Content
      </.styled_html>
      """,
      __ENV__
    )
  end

  test "Attribute: class" do
    assigns = %{}

    run_test(
      ~H"""
      <.styled_html class="my-content">
        Content
      </.styled_html>
      """,
      __ENV__
    )
  end

  test "Extra attributes" do
    assigns = %{}

    run_test(
      ~H"""
      <.styled_html dir="rtl">
        Content
      </.styled_html>
      """,
      __ENV__
    )
  end
end
