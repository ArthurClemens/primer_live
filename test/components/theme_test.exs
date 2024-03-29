defmodule PrimerLive.TestComponents.ThemeTest do
  use ExUnit.Case
  use PrimerLive
  import PrimerLive.Helpers.TestHelpers

  import Phoenix.Component
  import Phoenix.LiveViewTest

  test "Default values" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.theme>
             Content
           </.theme>
           """)
           |> format_html() ==
             """
             <div data-color-mode="auto" data-dark-theme="dark" data-light-theme="light">Content</div>
             """
             |> format_html()
  end

  test "Attribute: theme_state" do
    assigns = %{
      theme_state: %{
        color_mode: "dark",
        light_theme: "light_colorblind",
        dark_theme: "dark_high_contrast"
      }
    }

    assert rendered_to_string(~H"""
           <.theme theme_state={@theme_state}>
             Content
           </.theme>
           """)
           |> format_html() ==
             """
             <div data-color-mode="dark" data-dark-theme="dark_high_contrast" data-light-theme="light_colorblind">Content</div>
             """
             |> format_html()
  end

  test "Attribute: color_mode" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.theme color_mode="dark">
             Content
           </.theme>
           <.theme color_mode="light">
             Content
           </.theme>
           <.theme color_mode="auto">
             Content
           </.theme>
           """)
           |> format_html() ==
             """
             <div data-color-mode="dark" data-dark-theme="dark" data-light-theme="light">Content</div>
             <div data-color-mode="light" data-dark-theme="dark" data-light-theme="light">Content</div>
             <div data-color-mode="auto" data-dark-theme="dark" data-light-theme="light">Content</div>
             """
             |> format_html()
  end

  test "Attribute: light_theme, dark_theme" do
    assigns = %{}

    assert rendered_to_string(~H"""
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
           """)
           |> format_html() ==
             """
             <div data-color-mode="auto" data-dark-theme="dark" data-light-theme="light">default</div>
             <div data-color-mode="auto" data-dark-theme="dark" data-light-theme="light">light</div>
             <div data-color-mode="auto" data-dark-theme="dark" data-light-theme="light_high_contrast">light_high_contrast</div>
             <div data-color-mode="auto" data-dark-theme="dark" data-light-theme="light_colorblind">light_colorblind</div>
             <div data-color-mode="auto" data-dark-theme="dark" data-light-theme="light_tritanopia">light_tritanopia</div>
             <div data-color-mode="auto" data-dark-theme="dark" data-light-theme="light">dark</div>
             <div data-color-mode="auto" data-dark-theme="dark_dimmed" data-light-theme="light">dark_dimmed</div>
             <div data-color-mode="auto" data-dark-theme="dark_high_contrast" data-light-theme="light">dark_high_contrast</div>
             <div data-color-mode="auto" data-dark-theme="dark_colorblind" data-light-theme="light">dark_colorblind</div>
             <div data-color-mode="auto" data-dark-theme="dark_tritanopia" data-light-theme="light">dark_tritanopia</div>
             """
             |> format_html()
  end

  test "Attribute: inline" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.theme is_inline>
             Content
           </.theme>
           """)
           |> format_html() ==
             """
             <span data-color-mode="auto" data-dark-theme="dark" data-light-theme="light">Content</span>
             """
             |> format_html()
  end

  test "Additional attributes" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.theme class="my-theme" dir="rtl">
             Content
           </.theme>
           """)
           |> format_html() ==
             """
             <div class="my-theme" data-color-mode="auto" data-dark-theme="dark" data-light-theme="light" dir="rtl">Content</div>
             """
             |> format_html()
  end
end
