defmodule PrimerLive.TestComponents.ThemeMenuOptionsTest do
  use ExUnit.Case
  use PrimerLive
  import PrimerLive.Helpers.TestHelpers

  import Phoenix.Component
  import Phoenix.LiveViewTest

  test "Attribute: theme_state" do
    assigns = %{
      theme_state: %{
        color_mode: "light",
        light_theme: "light_high_contrast",
        dark_theme: "dark_high_contrast"
      }
    }

    assert rendered_to_string(~H"""
           <.theme_menu_options theme_state={@theme_state} />
           """)
           |> format_html() ==
             """
             <ul class="ActionList" role="listbox">
             <li class="ActionList-sectionDivider">
             <h3 class="ActionList-sectionDivider-title">Theme</h3>
             </li>
             <li class="ActionList-item" phx-click="update_theme" phx-value-data="light" phx-value-key="color_mode" role="option">
             <span class="ActionList-content"><span class="ActionList-item-visual ActionList-item-visual--leading"><span
             class="FormControl-checkbox-wrap ActionList-item-singleSelectCheckmark"><input checked
             class="FormControl-checkbox" type="checkbox" value="true" /></span></span><span
             class="ActionList-item-label">Light</span></span></li>
             <li class="ActionList-item" phx-click="update_theme" phx-value-data="dark" phx-value-key="color_mode" role="option">
             <span class="ActionList-content"><span class="ActionList-item-visual ActionList-item-visual--leading"><span
             class="FormControl-checkbox-wrap ActionList-item-singleSelectCheckmark"><input class="FormControl-checkbox"
             type="checkbox" value="true" /></span></span><span class="ActionList-item-label">Dark</span></span></li>
             <li class="ActionList-item" phx-click="update_theme" phx-value-data="auto" phx-value-key="color_mode" role="option">
             <span class="ActionList-content"><span class="ActionList-item-visual ActionList-item-visual--leading"><span
             class="FormControl-checkbox-wrap ActionList-item-singleSelectCheckmark"><input class="FormControl-checkbox"
             type="checkbox" value="true" /></span></span><span class="ActionList-item-label">System</span></span></li>
             <li aria-hidden="true" class="ActionList-sectionDivider" role="separator"></li>
             <li class="ActionList-sectionDivider">
             <h3 class="ActionList-sectionDivider-title">Light tone</h3>
             </li>
             <li class="ActionList-item" phx-click="update_theme" phx-value-data="light" phx-value-key="light_theme" role="option">
             <span class="ActionList-content"><span class="ActionList-item-visual ActionList-item-visual--leading"><span
             class="FormControl-checkbox-wrap ActionList-item-singleSelectCheckmark"><input class="FormControl-checkbox"
             type="checkbox" value="true" /></span></span><span class="ActionList-item-label">Light</span></span></li>
             <li class="ActionList-item" phx-click="update_theme" phx-value-data="light_high_contrast" phx-value-key="light_theme"
             role="option"><span class="ActionList-content"><span
             class="ActionList-item-visual ActionList-item-visual--leading"><span
             class="FormControl-checkbox-wrap ActionList-item-singleSelectCheckmark"><input checked
             class="FormControl-checkbox" type="checkbox" value="true" /></span></span><span
             class="ActionList-item-label">Light high contrast</span></span></li>
             <li class="ActionList-item" phx-click="update_theme" phx-value-data="light_colorblind" phx-value-key="light_theme"
             role="option"><span class="ActionList-content"><span
             class="ActionList-item-visual ActionList-item-visual--leading"><span
             class="FormControl-checkbox-wrap ActionList-item-singleSelectCheckmark"><input class="FormControl-checkbox"
             type="checkbox" value="true" /></span></span><span class="ActionList-item-label">Light
             colorblind</span></span></li>
             <li class="ActionList-item" phx-click="update_theme" phx-value-data="light_tritanopia" phx-value-key="light_theme"
             role="option"><span class="ActionList-content"><span
             class="ActionList-item-visual ActionList-item-visual--leading"><span
             class="FormControl-checkbox-wrap ActionList-item-singleSelectCheckmark"><input class="FormControl-checkbox"
             type="checkbox" value="true" /></span></span><span class="ActionList-item-label">Light
             Tritanopia</span></span></li>
             <li aria-hidden="true" class="ActionList-sectionDivider" role="separator"></li>
             <li class="ActionList-sectionDivider">
             <h3 class="ActionList-sectionDivider-title">Dark tone</h3>
             </li>
             <li class="ActionList-item" phx-click="update_theme" phx-value-data="dark" phx-value-key="dark_theme" role="option">
             <span class="ActionList-content"><span class="ActionList-item-visual ActionList-item-visual--leading"><span
             class="FormControl-checkbox-wrap ActionList-item-singleSelectCheckmark"><input class="FormControl-checkbox"
             type="checkbox" value="true" /></span></span><span class="ActionList-item-label">Dark</span></span></li>
             <li class="ActionList-item" phx-click="update_theme" phx-value-data="dark_dimmed" phx-value-key="dark_theme"
             role="option"><span class="ActionList-content"><span
             class="ActionList-item-visual ActionList-item-visual--leading"><span
             class="FormControl-checkbox-wrap ActionList-item-singleSelectCheckmark"><input class="FormControl-checkbox"
             type="checkbox" value="true" /></span></span><span class="ActionList-item-label">Dark dimmed</span></span>
             </li>
             <li class="ActionList-item" phx-click="update_theme" phx-value-data="dark_high_contrast" phx-value-key="dark_theme"
             role="option"><span class="ActionList-content"><span
             class="ActionList-item-visual ActionList-item-visual--leading"><span
             class="FormControl-checkbox-wrap ActionList-item-singleSelectCheckmark"><input checked
             class="FormControl-checkbox" type="checkbox" value="true" /></span></span><span
             class="ActionList-item-label">Dark high contrast</span></span></li>
             <li class="ActionList-item" phx-click="update_theme" phx-value-data="dark_colorblind" phx-value-key="dark_theme"
             role="option"><span class="ActionList-content"><span
             class="ActionList-item-visual ActionList-item-visual--leading"><span
             class="FormControl-checkbox-wrap ActionList-item-singleSelectCheckmark"><input class="FormControl-checkbox"
             type="checkbox" value="true" /></span></span><span class="ActionList-item-label">Dark
             colorblind</span></span></li>
             <li class="ActionList-item" phx-click="update_theme" phx-value-data="dark_tritanopia" phx-value-key="dark_theme"
             role="option"><span class="ActionList-content"><span
             class="ActionList-item-visual ActionList-item-visual--leading"><span
             class="FormControl-checkbox-wrap ActionList-item-singleSelectCheckmark"><input class="FormControl-checkbox"
             type="checkbox" value="true" /></span></span><span class="ActionList-item-label">Dark
             Tritanopia</span></span></li>
             <li aria-hidden="true" class="ActionList-sectionDivider" role="separator"></li>
             <li class="ActionList-item" phx-click="update_theme" phx-value-data="" phx-value-key="reset"><span
             class="ActionList-content"><span class="ActionList-item-label">Reset to default</span></span></li>
             </ul>
             """
             |> format_html()
  end

  test "Attribute: options" do
    assigns = %{
      theme_state: %{
        color_mode: "light",
        light_theme: "light_high_contrast",
        dark_theme: "dark_high_contrast"
      },
      options: %{
        color_mode: ~w(light dark),
        light_theme: ~w(light light_high_contrast),
        dark_theme: ~w(dark dark_dimmed)
      }
    }

    assert rendered_to_string(~H"""
           <.theme_menu_options theme_state={@theme_state} options={@options} />
           """)
           |> format_html() ==
             """
             <ul class="ActionList" role="listbox">
             <li class="ActionList-sectionDivider">
             <h3 class="ActionList-sectionDivider-title">Theme</h3>
             </li>
             <li class="ActionList-item" phx-click="update_theme" phx-value-data="light" phx-value-key="color_mode" role="option">
             <span class="ActionList-content"><span class="ActionList-item-visual ActionList-item-visual--leading"><span
             class="FormControl-checkbox-wrap ActionList-item-singleSelectCheckmark"><input checked
             class="FormControl-checkbox" type="checkbox" value="true" /></span></span><span
             class="ActionList-item-label">Light</span></span></li>
             <li class="ActionList-item" phx-click="update_theme" phx-value-data="dark" phx-value-key="color_mode" role="option">
             <span class="ActionList-content"><span class="ActionList-item-visual ActionList-item-visual--leading"><span
             class="FormControl-checkbox-wrap ActionList-item-singleSelectCheckmark"><input class="FormControl-checkbox"
             type="checkbox" value="true" /></span></span><span class="ActionList-item-label">Dark</span></span></li>
             <li aria-hidden="true" class="ActionList-sectionDivider" role="separator"></li>
             <li class="ActionList-sectionDivider">
             <h3 class="ActionList-sectionDivider-title">Light tone</h3>
             </li>
             <li class="ActionList-item" phx-click="update_theme" phx-value-data="light" phx-value-key="light_theme" role="option">
             <span class="ActionList-content"><span class="ActionList-item-visual ActionList-item-visual--leading"><span
             class="FormControl-checkbox-wrap ActionList-item-singleSelectCheckmark"><input class="FormControl-checkbox"
             type="checkbox" value="true" /></span></span><span class="ActionList-item-label">Light</span></span></li>
             <li class="ActionList-item" phx-click="update_theme" phx-value-data="light_high_contrast" phx-value-key="light_theme"
             role="option"><span class="ActionList-content"><span
             class="ActionList-item-visual ActionList-item-visual--leading"><span
             class="FormControl-checkbox-wrap ActionList-item-singleSelectCheckmark"><input checked
             class="FormControl-checkbox" type="checkbox" value="true" /></span></span><span
             class="ActionList-item-label">Light high contrast</span></span></li>
             <li aria-hidden="true" class="ActionList-sectionDivider" role="separator"></li>
             <li class="ActionList-sectionDivider">
             <h3 class="ActionList-sectionDivider-title">Dark tone</h3>
             </li>
             <li class="ActionList-item" phx-click="update_theme" phx-value-data="dark" phx-value-key="dark_theme" role="option">
             <span class="ActionList-content"><span class="ActionList-item-visual ActionList-item-visual--leading"><span
             class="FormControl-checkbox-wrap ActionList-item-singleSelectCheckmark"><input class="FormControl-checkbox"
             type="checkbox" value="true" /></span></span><span class="ActionList-item-label">Dark</span></span></li>
             <li class="ActionList-item" phx-click="update_theme" phx-value-data="dark_dimmed" phx-value-key="dark_theme"
             role="option"><span class="ActionList-content"><span
             class="ActionList-item-visual ActionList-item-visual--leading"><span
             class="FormControl-checkbox-wrap ActionList-item-singleSelectCheckmark"><input class="FormControl-checkbox"
             type="checkbox" value="true" /></span></span><span class="ActionList-item-label">Dark dimmed</span></span>
             </li>
             <li aria-hidden="true" class="ActionList-sectionDivider" role="separator"></li>
             <li class="ActionList-item" phx-click="update_theme" phx-value-data="" phx-value-key="reset"><span
             class="ActionList-content"><span class="ActionList-item-label">Reset to default</span></span></li>
             </ul>
             """
             |> format_html()
  end

  test "Attribute: update_theme_event" do
    assigns = %{
      theme_state: %{
        color_mode: "light",
        light_theme: "light_high_contrast",
        dark_theme: "dark_high_contrast"
      }
    }

    assert rendered_to_string(~H"""
           <.theme_menu_options theme_state={@theme_state} update_theme_event="store_browser_settings" />
           """)
           |> format_html() ==
             """
             <ul class="ActionList" role="listbox">
             <li class="ActionList-sectionDivider">
             <h3 class="ActionList-sectionDivider-title">Theme</h3>
             </li>
             <li class="ActionList-item" phx-click="store_browser_settings" phx-value-data="light" phx-value-key="color_mode"
             role="option"><span class="ActionList-content"><span
             class="ActionList-item-visual ActionList-item-visual--leading"><span
             class="FormControl-checkbox-wrap ActionList-item-singleSelectCheckmark"><input checked
             class="FormControl-checkbox" type="checkbox" value="true" /></span></span><span
             class="ActionList-item-label">Light</span></span></li>
             <li class="ActionList-item" phx-click="store_browser_settings" phx-value-data="dark" phx-value-key="color_mode"
             role="option"><span class="ActionList-content"><span
             class="ActionList-item-visual ActionList-item-visual--leading"><span
             class="FormControl-checkbox-wrap ActionList-item-singleSelectCheckmark"><input class="FormControl-checkbox"
             type="checkbox" value="true" /></span></span><span class="ActionList-item-label">Dark</span></span></li>
             <li class="ActionList-item" phx-click="store_browser_settings" phx-value-data="auto" phx-value-key="color_mode"
             role="option"><span class="ActionList-content"><span
             class="ActionList-item-visual ActionList-item-visual--leading"><span
             class="FormControl-checkbox-wrap ActionList-item-singleSelectCheckmark"><input class="FormControl-checkbox"
             type="checkbox" value="true" /></span></span><span class="ActionList-item-label">System</span></span></li>
             <li aria-hidden="true" class="ActionList-sectionDivider" role="separator"></li>
             <li class="ActionList-sectionDivider">
             <h3 class="ActionList-sectionDivider-title">Light tone</h3>
             </li>
             <li class="ActionList-item" phx-click="store_browser_settings" phx-value-data="light" phx-value-key="light_theme"
             role="option"><span class="ActionList-content"><span
             class="ActionList-item-visual ActionList-item-visual--leading"><span
             class="FormControl-checkbox-wrap ActionList-item-singleSelectCheckmark"><input class="FormControl-checkbox"
             type="checkbox" value="true" /></span></span><span class="ActionList-item-label">Light</span></span></li>
             <li class="ActionList-item" phx-click="store_browser_settings" phx-value-data="light_high_contrast"
             phx-value-key="light_theme" role="option"><span class="ActionList-content"><span
             class="ActionList-item-visual ActionList-item-visual--leading"><span
             class="FormControl-checkbox-wrap ActionList-item-singleSelectCheckmark"><input checked
             class="FormControl-checkbox" type="checkbox" value="true" /></span></span><span
             class="ActionList-item-label">Light high contrast</span></span></li>
             <li class="ActionList-item" phx-click="store_browser_settings" phx-value-data="light_colorblind"
             phx-value-key="light_theme" role="option"><span class="ActionList-content"><span
             class="ActionList-item-visual ActionList-item-visual--leading"><span
             class="FormControl-checkbox-wrap ActionList-item-singleSelectCheckmark"><input class="FormControl-checkbox"
             type="checkbox" value="true" /></span></span><span class="ActionList-item-label">Light
             colorblind</span></span></li>
             <li class="ActionList-item" phx-click="store_browser_settings" phx-value-data="light_tritanopia"
             phx-value-key="light_theme" role="option"><span class="ActionList-content"><span
             class="ActionList-item-visual ActionList-item-visual--leading"><span
             class="FormControl-checkbox-wrap ActionList-item-singleSelectCheckmark"><input class="FormControl-checkbox"
             type="checkbox" value="true" /></span></span><span class="ActionList-item-label">Light
             Tritanopia</span></span></li>
             <li aria-hidden="true" class="ActionList-sectionDivider" role="separator"></li>
             <li class="ActionList-sectionDivider">
             <h3 class="ActionList-sectionDivider-title">Dark tone</h3>
             </li>
             <li class="ActionList-item" phx-click="store_browser_settings" phx-value-data="dark" phx-value-key="dark_theme"
             role="option"><span class="ActionList-content"><span
             class="ActionList-item-visual ActionList-item-visual--leading"><span
             class="FormControl-checkbox-wrap ActionList-item-singleSelectCheckmark"><input class="FormControl-checkbox"
             type="checkbox" value="true" /></span></span><span class="ActionList-item-label">Dark</span></span></li>
             <li class="ActionList-item" phx-click="store_browser_settings" phx-value-data="dark_dimmed" phx-value-key="dark_theme"
             role="option"><span class="ActionList-content"><span
             class="ActionList-item-visual ActionList-item-visual--leading"><span
             class="FormControl-checkbox-wrap ActionList-item-singleSelectCheckmark"><input class="FormControl-checkbox"
             type="checkbox" value="true" /></span></span><span class="ActionList-item-label">Dark dimmed</span></span>
             </li>
             <li class="ActionList-item" phx-click="store_browser_settings" phx-value-data="dark_high_contrast"
             phx-value-key="dark_theme" role="option"><span class="ActionList-content"><span
             class="ActionList-item-visual ActionList-item-visual--leading"><span
             class="FormControl-checkbox-wrap ActionList-item-singleSelectCheckmark"><input checked
             class="FormControl-checkbox" type="checkbox" value="true" /></span></span><span
             class="ActionList-item-label">Dark high contrast</span></span></li>
             <li class="ActionList-item" phx-click="store_browser_settings" phx-value-data="dark_colorblind"
             phx-value-key="dark_theme" role="option"><span class="ActionList-content"><span
             class="ActionList-item-visual ActionList-item-visual--leading"><span
             class="FormControl-checkbox-wrap ActionList-item-singleSelectCheckmark"><input class="FormControl-checkbox"
             type="checkbox" value="true" /></span></span><span class="ActionList-item-label">Dark
             colorblind</span></span></li>
             <li class="ActionList-item" phx-click="store_browser_settings" phx-value-data="dark_tritanopia"
             phx-value-key="dark_theme" role="option"><span class="ActionList-content"><span
             class="ActionList-item-visual ActionList-item-visual--leading"><span
             class="FormControl-checkbox-wrap ActionList-item-singleSelectCheckmark"><input class="FormControl-checkbox"
             type="checkbox" value="true" /></span></span><span class="ActionList-item-label">Dark
             Tritanopia</span></span></li>
             <li aria-hidden="true" class="ActionList-sectionDivider" role="separator"></li>
             <li class="ActionList-item" phx-click="store_browser_settings" phx-value-data="" phx-value-key="reset"><span
             class="ActionList-content"><span class="ActionList-item-label">Reset to default</span></span></li>
             </ul>
             """
             |> format_html()
  end

  test "Attribute: labels" do
    assigns = %{
      theme_state: %{
        color_mode: "light",
        light_theme: "light_high_contrast",
        dark_theme: "dark_high_contrast"
      },
      options: %{
        color_mode: ~w(light dark)
      },
      labels: %{
        color_mode: %{
          light: "Light theme"
        },
        reset: "Reset"
      }
    }

    assert rendered_to_string(~H"""
           <.theme_menu_options theme_state={@theme_state} options={@options} labels={@labels} />
           """)
           |> format_html() ==
             """
             <ul class="ActionList" role="listbox">
             <li class="ActionList-sectionDivider">
             <h3 class="ActionList-sectionDivider-title">Theme</h3>
             </li>
             <li class="ActionList-item" phx-click="update_theme" phx-value-data="light" phx-value-key="color_mode" role="option">
             <span class="ActionList-content"><span class="ActionList-item-visual ActionList-item-visual--leading"><span
             class="FormControl-checkbox-wrap ActionList-item-singleSelectCheckmark"><input checked
             class="FormControl-checkbox" type="checkbox" value="true" /></span></span><span
             class="ActionList-item-label">Light theme</span></span></li>
             <li class="ActionList-item" phx-click="update_theme" phx-value-data="dark" phx-value-key="color_mode" role="option">
             <span class="ActionList-content"><span class="ActionList-item-visual ActionList-item-visual--leading"><span
             class="FormControl-checkbox-wrap ActionList-item-singleSelectCheckmark"><input class="FormControl-checkbox"
             type="checkbox" value="true" /></span></span><span class="ActionList-item-label">Dark</span></span></li>
             <li aria-hidden="true" class="ActionList-sectionDivider" role="separator"></li>
             <li class="ActionList-item" phx-click="update_theme" phx-value-data="" phx-value-key="reset"><span
             class="ActionList-content"><span class="ActionList-item-label">Reset</span></span></li>
             </ul>
             """
             |> format_html()
  end

  test "Attribute: is_show_group_labels (false)" do
    assigns = %{
      theme_state: %{
        color_mode: "light",
        light_theme: "light_high_contrast",
        dark_theme: "dark_high_contrast"
      },
      is_show_group_labels: false
    }

    assert rendered_to_string(~H"""
           <.theme_menu_options theme_state={@theme_state} is_show_group_labels={@is_show_group_labels} />
           """)
           |> format_html() ==
             """
             <ul class="ActionList" role="listbox">
             <li class="ActionList-item" phx-click="update_theme" phx-value-data="light" phx-value-key="color_mode" role="option">
             <span class="ActionList-content"><span class="ActionList-item-visual ActionList-item-visual--leading"><span
             class="FormControl-checkbox-wrap ActionList-item-singleSelectCheckmark"><input checked
             class="FormControl-checkbox" type="checkbox" value="true" /></span></span><span
             class="ActionList-item-label">Light</span></span></li>
             <li class="ActionList-item" phx-click="update_theme" phx-value-data="dark" phx-value-key="color_mode" role="option">
             <span class="ActionList-content"><span class="ActionList-item-visual ActionList-item-visual--leading"><span
             class="FormControl-checkbox-wrap ActionList-item-singleSelectCheckmark"><input class="FormControl-checkbox"
             type="checkbox" value="true" /></span></span><span class="ActionList-item-label">Dark</span></span></li>
             <li class="ActionList-item" phx-click="update_theme" phx-value-data="auto" phx-value-key="color_mode" role="option">
             <span class="ActionList-content"><span class="ActionList-item-visual ActionList-item-visual--leading"><span
             class="FormControl-checkbox-wrap ActionList-item-singleSelectCheckmark"><input class="FormControl-checkbox"
             type="checkbox" value="true" /></span></span><span class="ActionList-item-label">System</span></span></li>
             <li aria-hidden="true" class="ActionList-sectionDivider" role="separator"></li>
             <li class="ActionList-item" phx-click="update_theme" phx-value-data="light" phx-value-key="light_theme" role="option">
             <span class="ActionList-content"><span class="ActionList-item-visual ActionList-item-visual--leading"><span
             class="FormControl-checkbox-wrap ActionList-item-singleSelectCheckmark"><input class="FormControl-checkbox"
             type="checkbox" value="true" /></span></span><span class="ActionList-item-label">Light</span></span></li>
             <li class="ActionList-item" phx-click="update_theme" phx-value-data="light_high_contrast" phx-value-key="light_theme"
             role="option"><span class="ActionList-content"><span
             class="ActionList-item-visual ActionList-item-visual--leading"><span
             class="FormControl-checkbox-wrap ActionList-item-singleSelectCheckmark"><input checked
             class="FormControl-checkbox" type="checkbox" value="true" /></span></span><span
             class="ActionList-item-label">Light high contrast</span></span></li>
             <li class="ActionList-item" phx-click="update_theme" phx-value-data="light_colorblind" phx-value-key="light_theme"
             role="option"><span class="ActionList-content"><span
             class="ActionList-item-visual ActionList-item-visual--leading"><span
             class="FormControl-checkbox-wrap ActionList-item-singleSelectCheckmark"><input class="FormControl-checkbox"
             type="checkbox" value="true" /></span></span><span class="ActionList-item-label">Light
             colorblind</span></span></li>
             <li class="ActionList-item" phx-click="update_theme" phx-value-data="light_tritanopia" phx-value-key="light_theme"
             role="option"><span class="ActionList-content"><span
             class="ActionList-item-visual ActionList-item-visual--leading"><span
             class="FormControl-checkbox-wrap ActionList-item-singleSelectCheckmark"><input class="FormControl-checkbox"
             type="checkbox" value="true" /></span></span><span class="ActionList-item-label">Light
             Tritanopia</span></span></li>
             <li aria-hidden="true" class="ActionList-sectionDivider" role="separator"></li>
             <li class="ActionList-item" phx-click="update_theme" phx-value-data="dark" phx-value-key="dark_theme" role="option">
             <span class="ActionList-content"><span class="ActionList-item-visual ActionList-item-visual--leading"><span
             class="FormControl-checkbox-wrap ActionList-item-singleSelectCheckmark"><input class="FormControl-checkbox"
             type="checkbox" value="true" /></span></span><span class="ActionList-item-label">Dark</span></span></li>
             <li class="ActionList-item" phx-click="update_theme" phx-value-data="dark_dimmed" phx-value-key="dark_theme"
             role="option"><span class="ActionList-content"><span
             class="ActionList-item-visual ActionList-item-visual--leading"><span
             class="FormControl-checkbox-wrap ActionList-item-singleSelectCheckmark"><input class="FormControl-checkbox"
             type="checkbox" value="true" /></span></span><span class="ActionList-item-label">Dark dimmed</span></span>
             </li>
             <li class="ActionList-item" phx-click="update_theme" phx-value-data="dark_high_contrast" phx-value-key="dark_theme"
             role="option"><span class="ActionList-content"><span
             class="ActionList-item-visual ActionList-item-visual--leading"><span
             class="FormControl-checkbox-wrap ActionList-item-singleSelectCheckmark"><input checked
             class="FormControl-checkbox" type="checkbox" value="true" /></span></span><span
             class="ActionList-item-label">Dark high contrast</span></span></li>
             <li class="ActionList-item" phx-click="update_theme" phx-value-data="dark_colorblind" phx-value-key="dark_theme"
             role="option"><span class="ActionList-content"><span
             class="ActionList-item-visual ActionList-item-visual--leading"><span
             class="FormControl-checkbox-wrap ActionList-item-singleSelectCheckmark"><input class="FormControl-checkbox"
             type="checkbox" value="true" /></span></span><span class="ActionList-item-label">Dark
             colorblind</span></span></li>
             <li class="ActionList-item" phx-click="update_theme" phx-value-data="dark_tritanopia" phx-value-key="dark_theme"
             role="option"><span class="ActionList-content"><span
             class="ActionList-item-visual ActionList-item-visual--leading"><span
             class="FormControl-checkbox-wrap ActionList-item-singleSelectCheckmark"><input class="FormControl-checkbox"
             type="checkbox" value="true" /></span></span><span class="ActionList-item-label">Dark
             Tritanopia</span></span></li>
             <li aria-hidden="true" class="ActionList-sectionDivider" role="separator"></li>
             <li class="ActionList-item" phx-click="update_theme" phx-value-data="" phx-value-key="reset"><span
             class="ActionList-content"><span class="ActionList-item-label">Reset to default</span></span></li>
             </ul>
             """
             |> format_html()
  end

  test "Attribute: is_show_reset_link (false)" do
    assigns = %{
      theme_state: %{
        color_mode: "light",
        light_theme: "light_high_contrast",
        dark_theme: "dark_high_contrast"
      },
      is_show_reset_link: false
    }

    assert rendered_to_string(~H"""
           <.theme_menu_options theme_state={@theme_state} is_show_reset_link={@is_show_reset_link} />
           """)
           |> format_html() ==
             """
             <ul class="ActionList" role="listbox">
             <li class="ActionList-sectionDivider">
             <h3 class="ActionList-sectionDivider-title">Theme</h3>
             </li>
             <li class="ActionList-item" phx-click="update_theme" phx-value-data="light" phx-value-key="color_mode" role="option">
             <span class="ActionList-content"><span class="ActionList-item-visual ActionList-item-visual--leading"><span
             class="FormControl-checkbox-wrap ActionList-item-singleSelectCheckmark"><input checked
             class="FormControl-checkbox" type="checkbox" value="true" /></span></span><span
             class="ActionList-item-label">Light</span></span></li>
             <li class="ActionList-item" phx-click="update_theme" phx-value-data="dark" phx-value-key="color_mode" role="option">
             <span class="ActionList-content"><span class="ActionList-item-visual ActionList-item-visual--leading"><span
             class="FormControl-checkbox-wrap ActionList-item-singleSelectCheckmark"><input class="FormControl-checkbox"
             type="checkbox" value="true" /></span></span><span class="ActionList-item-label">Dark</span></span></li>
             <li class="ActionList-item" phx-click="update_theme" phx-value-data="auto" phx-value-key="color_mode" role="option">
             <span class="ActionList-content"><span class="ActionList-item-visual ActionList-item-visual--leading"><span
             class="FormControl-checkbox-wrap ActionList-item-singleSelectCheckmark"><input class="FormControl-checkbox"
             type="checkbox" value="true" /></span></span><span class="ActionList-item-label">System</span></span></li>
             <li aria-hidden="true" class="ActionList-sectionDivider" role="separator"></li>
             <li class="ActionList-sectionDivider">
             <h3 class="ActionList-sectionDivider-title">Light tone</h3>
             </li>
             <li class="ActionList-item" phx-click="update_theme" phx-value-data="light" phx-value-key="light_theme" role="option">
             <span class="ActionList-content"><span class="ActionList-item-visual ActionList-item-visual--leading"><span
             class="FormControl-checkbox-wrap ActionList-item-singleSelectCheckmark"><input class="FormControl-checkbox"
             type="checkbox" value="true" /></span></span><span class="ActionList-item-label">Light</span></span></li>
             <li class="ActionList-item" phx-click="update_theme" phx-value-data="light_high_contrast" phx-value-key="light_theme"
             role="option"><span class="ActionList-content"><span
             class="ActionList-item-visual ActionList-item-visual--leading"><span
             class="FormControl-checkbox-wrap ActionList-item-singleSelectCheckmark"><input checked
             class="FormControl-checkbox" type="checkbox" value="true" /></span></span><span
             class="ActionList-item-label">Light high contrast</span></span></li>
             <li class="ActionList-item" phx-click="update_theme" phx-value-data="light_colorblind" phx-value-key="light_theme"
             role="option"><span class="ActionList-content"><span
             class="ActionList-item-visual ActionList-item-visual--leading"><span
             class="FormControl-checkbox-wrap ActionList-item-singleSelectCheckmark"><input class="FormControl-checkbox"
             type="checkbox" value="true" /></span></span><span class="ActionList-item-label">Light
             colorblind</span></span></li>
             <li class="ActionList-item" phx-click="update_theme" phx-value-data="light_tritanopia" phx-value-key="light_theme"
             role="option"><span class="ActionList-content"><span
             class="ActionList-item-visual ActionList-item-visual--leading"><span
             class="FormControl-checkbox-wrap ActionList-item-singleSelectCheckmark"><input class="FormControl-checkbox"
             type="checkbox" value="true" /></span></span><span class="ActionList-item-label">Light
             Tritanopia</span></span></li>
             <li aria-hidden="true" class="ActionList-sectionDivider" role="separator"></li>
             <li class="ActionList-sectionDivider">
             <h3 class="ActionList-sectionDivider-title">Dark tone</h3>
             </li>
             <li class="ActionList-item" phx-click="update_theme" phx-value-data="dark" phx-value-key="dark_theme" role="option">
             <span class="ActionList-content"><span class="ActionList-item-visual ActionList-item-visual--leading"><span
             class="FormControl-checkbox-wrap ActionList-item-singleSelectCheckmark"><input class="FormControl-checkbox"
             type="checkbox" value="true" /></span></span><span class="ActionList-item-label">Dark</span></span></li>
             <li class="ActionList-item" phx-click="update_theme" phx-value-data="dark_dimmed" phx-value-key="dark_theme"
             role="option"><span class="ActionList-content"><span
             class="ActionList-item-visual ActionList-item-visual--leading"><span
             class="FormControl-checkbox-wrap ActionList-item-singleSelectCheckmark"><input class="FormControl-checkbox"
             type="checkbox" value="true" /></span></span><span class="ActionList-item-label">Dark dimmed</span></span>
             </li>
             <li class="ActionList-item" phx-click="update_theme" phx-value-data="dark_high_contrast" phx-value-key="dark_theme"
             role="option"><span class="ActionList-content"><span
             class="ActionList-item-visual ActionList-item-visual--leading"><span
             class="FormControl-checkbox-wrap ActionList-item-singleSelectCheckmark"><input checked
             class="FormControl-checkbox" type="checkbox" value="true" /></span></span><span
             class="ActionList-item-label">Dark high contrast</span></span></li>
             <li class="ActionList-item" phx-click="update_theme" phx-value-data="dark_colorblind" phx-value-key="dark_theme"
             role="option"><span class="ActionList-content"><span
             class="ActionList-item-visual ActionList-item-visual--leading"><span
             class="FormControl-checkbox-wrap ActionList-item-singleSelectCheckmark"><input class="FormControl-checkbox"
             type="checkbox" value="true" /></span></span><span class="ActionList-item-label">Dark
             colorblind</span></span></li>
             <li class="ActionList-item" phx-click="update_theme" phx-value-data="dark_tritanopia" phx-value-key="dark_theme"
             role="option"><span class="ActionList-content"><span
             class="ActionList-item-visual ActionList-item-visual--leading"><span
             class="FormControl-checkbox-wrap ActionList-item-singleSelectCheckmark"><input class="FormControl-checkbox"
             type="checkbox" value="true" /></span></span><span class="ActionList-item-label">Dark
             Tritanopia</span></span></li>
             </ul>
             """
             |> format_html()
  end

  test "Extra attributes" do
    assigns = %{
      theme_state: %{
        color_mode: "light",
        light_theme: "light_high_contrast",
        dark_theme: "dark_high_contrast"
      }
    }

    assert rendered_to_string(~H"""
           <.theme_menu_options theme_state={@theme_state} dir="rtl" class="my-menu-options" />
           """)
           |> format_html() ==
             """
             <ul class="ActionList my-menu-options" dir="rtl" role="listbox">
             <li class="ActionList-sectionDivider">
             <h3 class="ActionList-sectionDivider-title">Theme</h3>
             </li>
             <li class="ActionList-item" phx-click="update_theme" phx-value-data="light" phx-value-key="color_mode" role="option">
             <span class="ActionList-content"><span class="ActionList-item-visual ActionList-item-visual--leading"><span
             class="FormControl-checkbox-wrap ActionList-item-singleSelectCheckmark"><input checked
             class="FormControl-checkbox" type="checkbox" value="true" /></span></span><span
             class="ActionList-item-label">Light</span></span></li>
             <li class="ActionList-item" phx-click="update_theme" phx-value-data="dark" phx-value-key="color_mode" role="option">
             <span class="ActionList-content"><span class="ActionList-item-visual ActionList-item-visual--leading"><span
             class="FormControl-checkbox-wrap ActionList-item-singleSelectCheckmark"><input class="FormControl-checkbox"
             type="checkbox" value="true" /></span></span><span class="ActionList-item-label">Dark</span></span></li>
             <li class="ActionList-item" phx-click="update_theme" phx-value-data="auto" phx-value-key="color_mode" role="option">
             <span class="ActionList-content"><span class="ActionList-item-visual ActionList-item-visual--leading"><span
             class="FormControl-checkbox-wrap ActionList-item-singleSelectCheckmark"><input class="FormControl-checkbox"
             type="checkbox" value="true" /></span></span><span class="ActionList-item-label">System</span></span></li>
             <li aria-hidden="true" class="ActionList-sectionDivider" role="separator"></li>
             <li class="ActionList-sectionDivider">
             <h3 class="ActionList-sectionDivider-title">Light tone</h3>
             </li>
             <li class="ActionList-item" phx-click="update_theme" phx-value-data="light" phx-value-key="light_theme" role="option">
             <span class="ActionList-content"><span class="ActionList-item-visual ActionList-item-visual--leading"><span
             class="FormControl-checkbox-wrap ActionList-item-singleSelectCheckmark"><input class="FormControl-checkbox"
             type="checkbox" value="true" /></span></span><span class="ActionList-item-label">Light</span></span></li>
             <li class="ActionList-item" phx-click="update_theme" phx-value-data="light_high_contrast" phx-value-key="light_theme"
             role="option"><span class="ActionList-content"><span
             class="ActionList-item-visual ActionList-item-visual--leading"><span
             class="FormControl-checkbox-wrap ActionList-item-singleSelectCheckmark"><input checked
             class="FormControl-checkbox" type="checkbox" value="true" /></span></span><span
             class="ActionList-item-label">Light high contrast</span></span></li>
             <li class="ActionList-item" phx-click="update_theme" phx-value-data="light_colorblind" phx-value-key="light_theme"
             role="option"><span class="ActionList-content"><span
             class="ActionList-item-visual ActionList-item-visual--leading"><span
             class="FormControl-checkbox-wrap ActionList-item-singleSelectCheckmark"><input class="FormControl-checkbox"
             type="checkbox" value="true" /></span></span><span class="ActionList-item-label">Light
             colorblind</span></span></li>
             <li class="ActionList-item" phx-click="update_theme" phx-value-data="light_tritanopia" phx-value-key="light_theme"
             role="option"><span class="ActionList-content"><span
             class="ActionList-item-visual ActionList-item-visual--leading"><span
             class="FormControl-checkbox-wrap ActionList-item-singleSelectCheckmark"><input class="FormControl-checkbox"
             type="checkbox" value="true" /></span></span><span class="ActionList-item-label">Light
             Tritanopia</span></span></li>
             <li aria-hidden="true" class="ActionList-sectionDivider" role="separator"></li>
             <li class="ActionList-sectionDivider">
             <h3 class="ActionList-sectionDivider-title">Dark tone</h3>
             </li>
             <li class="ActionList-item" phx-click="update_theme" phx-value-data="dark" phx-value-key="dark_theme" role="option">
             <span class="ActionList-content"><span class="ActionList-item-visual ActionList-item-visual--leading"><span
             class="FormControl-checkbox-wrap ActionList-item-singleSelectCheckmark"><input class="FormControl-checkbox"
             type="checkbox" value="true" /></span></span><span class="ActionList-item-label">Dark</span></span></li>
             <li class="ActionList-item" phx-click="update_theme" phx-value-data="dark_dimmed" phx-value-key="dark_theme"
             role="option"><span class="ActionList-content"><span
             class="ActionList-item-visual ActionList-item-visual--leading"><span
             class="FormControl-checkbox-wrap ActionList-item-singleSelectCheckmark"><input class="FormControl-checkbox"
             type="checkbox" value="true" /></span></span><span class="ActionList-item-label">Dark dimmed</span></span>
             </li>
             <li class="ActionList-item" phx-click="update_theme" phx-value-data="dark_high_contrast" phx-value-key="dark_theme"
             role="option"><span class="ActionList-content"><span
             class="ActionList-item-visual ActionList-item-visual--leading"><span
             class="FormControl-checkbox-wrap ActionList-item-singleSelectCheckmark"><input checked
             class="FormControl-checkbox" type="checkbox" value="true" /></span></span><span
             class="ActionList-item-label">Dark high contrast</span></span></li>
             <li class="ActionList-item" phx-click="update_theme" phx-value-data="dark_colorblind" phx-value-key="dark_theme"
             role="option"><span class="ActionList-content"><span
             class="ActionList-item-visual ActionList-item-visual--leading"><span
             class="FormControl-checkbox-wrap ActionList-item-singleSelectCheckmark"><input class="FormControl-checkbox"
             type="checkbox" value="true" /></span></span><span class="ActionList-item-label">Dark
             colorblind</span></span></li>
             <li class="ActionList-item" phx-click="update_theme" phx-value-data="dark_tritanopia" phx-value-key="dark_theme"
             role="option"><span class="ActionList-content"><span
             class="ActionList-item-visual ActionList-item-visual--leading"><span
             class="FormControl-checkbox-wrap ActionList-item-singleSelectCheckmark"><input class="FormControl-checkbox"
             type="checkbox" value="true" /></span></span><span class="ActionList-item-label">Dark
             Tritanopia</span></span></li>
             <li aria-hidden="true" class="ActionList-sectionDivider" role="separator"></li>
             <li class="ActionList-item" phx-click="update_theme" phx-value-data="" phx-value-key="reset"><span
             class="ActionList-content"><span class="ActionList-item-label">Reset to default</span></span></li>
             </ul>
             """
             |> format_html()
  end
end
