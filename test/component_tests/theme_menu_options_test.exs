defmodule PrimerLive.TestComponents.ThemeMenuOptionsTest do
  @moduledoc false

  use PrimerLive.TestBase

  test "Attribute: theme_state" do
    assigns = %{
      theme_state: %{
        color_mode: "light",
        light_theme: "light_high_contrast",
        dark_theme: "dark_high_contrast"
      }
    }

    run_test(
      ~H"""
      <.theme_menu_options theme_state={@theme_state} />
      """,
      __ENV__
    )
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

    run_test(
      ~H"""
      <.theme_menu_options theme_state={@theme_state} options={@options} />
      """,
      __ENV__
    )
  end

  test "Attribute: update_theme_event" do
    assigns = %{
      theme_state: %{
        color_mode: "light",
        light_theme: "light_high_contrast",
        dark_theme: "dark_high_contrast"
      }
    }

    run_test(
      ~H"""
      <.theme_menu_options theme_state={@theme_state} update_theme_event="store_browser_settings" />
      """,
      __ENV__
    )
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

    run_test(
      ~H"""
      <.theme_menu_options theme_state={@theme_state} options={@options} labels={@labels} />
      """,
      __ENV__
    )
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

    run_test(
      ~H"""
      <.theme_menu_options theme_state={@theme_state} is_show_group_labels={@is_show_group_labels} />
      """,
      __ENV__
    )
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

    run_test(
      ~H"""
      <.theme_menu_options theme_state={@theme_state} is_show_reset_link={@is_show_reset_link} />
      """,
      __ENV__
    )
  end

  test "Extra attributes" do
    assigns = %{
      theme_state: %{
        color_mode: "light",
        light_theme: "light_high_contrast",
        dark_theme: "dark_high_contrast"
      }
    }

    run_test(
      ~H"""
      <.theme_menu_options theme_state={@theme_state} dir="rtl" class="my-menu-options" />
      """,
      __ENV__
    )
  end
end
