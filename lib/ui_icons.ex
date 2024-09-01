defmodule PrimerLive.UIIcons do
  @moduledoc """
  Interface icons that are not part of the Octicons set.
  """

  use Phoenix.Component

  require PrimerLive.Helpers.DeclarationHelpers

  @common_svg_attrs [
    viewBox: "0 0 16 16",
    xmlns: "http://www.w3.org/2000/svg",
    "aria-hidden": "true",
    focusable: "false"
  ]

  @doc """
  Internal use: attributes used in all SVG's.
  """
  def common_svg_attrs, do: @common_svg_attrs

  @doc """
  Internal use: generates a map of SVG's.

  To use the `PrimerLive.Component.ui_icon/1` component, write:
  ```
  <.ui_icon name="icon-name" />
  ```

  ## All UI icons

  ```
  <.ui_icon name="collapse-16" />
  <.ui_icon name="multiple-select-16" />
  <.ui_icon name="single-select-16" />
  <.ui_icon name="toggle-switch-off-16" />
  <.ui_icon name="toggle-switch-on-16" />
  ```
  """

  attr(:rest, :global,
    doc: """
    Additional HTML attributes added to the svg element.
    """
  )

  def ui_icons(assigns) do
    assigns =
      assigns
      |> assign(:common_attrs, @common_svg_attrs)

    %{
      "single-select-16" => ~H"""
      <svg {@common_attrs} width="16" height="16" {@rest}>
        <path
          fill-rule="evenodd"
          clip-rule="evenodd"
          d="M13.7799 4.22001C13.9203 4.36063 13.9992 4.55126 13.9992 4.75001C13.9992 4.94876 13.9203 5.13938 13.7799 5.28001L6.52985 12.53C6.38922 12.6704 6.1986 12.7493 5.99985 12.7493C5.8011 12.7493 5.61047 12.6704 5.46985 12.53L2.21985 9.28001C2.08737 9.13783 2.01525 8.94979 2.01867 8.75548C2.0221 8.56118 2.10081 8.3758 2.23823 8.23838C2.37564 8.10097 2.56103 8.02226 2.75533 8.01883C2.94963 8.0154 3.13767 8.08753 3.27985 8.22001L5.99985 10.94L12.7199 4.22001C12.8605 4.07956 13.0511 4.00067 13.2499 4.00067C13.4486 4.00067 13.6393 4.07956 13.7799 4.22001Z"
        />
      </svg>
      """,
      "multiple-select-16" => ~H"""
      <svg {@common_attrs} width="16" height="16" {@rest}>
        <rect x="2" y="2" width="12" height="12" rx="4" class="ActionList-item-multiSelectIconRect">
        </rect>
        <path
          fill-rule="evenodd"
          d="M4.03231 8.69862C3.84775 8.20646 4.49385 7.77554 4.95539 7.77554C5.41693 7.77554 6.80154 9.85246 6.80154 9.85246C6.80154 9.85246 10.2631 4.314 10.4938 4.08323C10.7246 3.85246 11.8785 4.08323 11.4169 5.00631C11.0081 5.82388 7.26308 11.4678 7.26308 11.4678C7.26308 11.4678 6.80154 12.1602 6.34 11.4678C5.87846 10.7755 4.21687 9.19077 4.03231 8.69862Z"
          class="ActionList-item-multiSelectCheckmark"
        >
        </path>
      </svg>
      """,
      "collapse-16" => ~H"""
      <svg {@common_attrs} width="16" height="16" {@rest}>
        <path
          fill-rule="evenodd"
          d="M12.78 6.22a.75.75 0 010 1.06l-4.25 4.25a.75.75 0 01-1.06 0L3.22 7.28a.75.75 0 011.06-1.06L8 9.94l3.72-3.72a.75.75 0 011.06 0z"
        >
        </path>
      </svg>
      """,
      "toggle-switch-on-16" => ~H"""
      <svg {@common_attrs} width="16" height="16" {@rest}>
        <path
          fill-rule="evenodd"
          d="M8 2a.75.75 0 0 1 .75.75v11.5a.75.75 0 0 1-1.5 0V2.75A.75.75 0 0 1 8 2Z"
        >
        </path>
      </svg>
      """,
      "toggle-switch-off-16" => ~H"""
      <svg {@common_attrs} width="16" height="16" {@rest}>
        <path
          fill-rule="evenodd"
          d="M8 12.5a4.5 4.5 0 1 0 0-9 4.5 4.5 0 0 0 0 9ZM8 14A6 6 0 1 0 8 2a6 6 0 0 0 0 12Z"
        >
        </path>
      </svg>
      """
    }
  end
end
