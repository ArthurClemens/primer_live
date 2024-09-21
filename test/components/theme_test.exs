defmodule PrimerLive.TestComponents.ThemeTest do
  @moduledoc false

  use PrimerLive.TestBase

  test "Default values" do
    assigns = %{}

    run_test(
      ~H"""
      <.theme>
        Content
      </.theme>
      """,
      __ENV__
    )
  end

  test "Attribute: theme_state" do
    assigns = %{
      theme_state: %{
        color_mode: "dark",
        light_theme: "light_colorblind",
        dark_theme: "dark_high_contrast"
      }
    }

    run_test(
      ~H"""
      <.theme theme_state={@theme_state}>
        Content
      </.theme>
      """,
      __ENV__
    )
  end

  test "Attribute: color_mode" do
    assigns = %{}

    run_test(
      ~H"""
      <.theme color_mode="dark">
        Content
      </.theme>
      <.theme color_mode="light">
        Content
      </.theme>
      <.theme color_mode="auto">
        Content
      </.theme>
      """,
      __ENV__
    )
  end

  test "Attribute: light_theme, dark_theme" do
    assigns = %{}

    run_test(
      ~H"""
      <.theme>
        default
      </.theme>
      <.theme light_theme="light">
        light
      </.theme>
      <.theme light_theme="light_high_contrast">
        light_high_contrast
      </.theme>
      <.theme light_theme="light_colorblind">
        light_colorblind
      </.theme>
      <.theme light_theme="light_tritanopia">
        light_tritanopia
      </.theme>
      <.theme dark_theme="dark">
        dark
      </.theme>
      <.theme dark_theme="dark_dimmed">
        dark_dimmed
      </.theme>
      <.theme dark_theme="dark_high_contrast">
        dark_high_contrast
      </.theme>
      <.theme dark_theme="dark_colorblind">
        dark_colorblind
      </.theme>
      <.theme dark_theme="dark_tritanopia">
        dark_tritanopia
      </.theme>
      """,
      __ENV__
    )
  end

  test "Attribute: inline" do
    assigns = %{}

    run_test(
      ~H"""
      <.theme is_inline>
        Content
      </.theme>
      """,
      __ENV__
    )
  end

  test "Additional attributes" do
    assigns = %{}

    run_test(
      ~H"""
      <.theme class="my-theme" dir="rtl">
        Content
      </.theme>
      """,
      __ENV__
    )
  end
end
