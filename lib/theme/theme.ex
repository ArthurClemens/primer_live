defmodule PrimerLive.Theme do
  @moduledoc """
  PrimerLive contains styles for light and dark color modes and themes, with support for color blindness.

  PrimerLive provides these theme components and functions:
  - [`theme/1`](`PrimerLive.Component.theme/1`) - wrapper to set the theme on child elements
  - [`theme_menu_options/1`](`PrimerLive.Component.theme_menu_options/1`) - contents for a theme menu
  - `html_attributes/2` - HTML attributes to set a theme on a component or element directly

  ## Theme component

  The `theme/1` component sets the required HTML attributes.

  Default settings (light theme):

  ```
  <.theme>
    Content
  </.theme>
  ```

  To hardcode the theme to dark mode:

  ```
  <.theme color_mode="dark" dark_theme="dark_dimmed">
    Content
  </.theme>
  ```

  Usually, the theme is set to user preferences. A menu with theme options can be created with `theme_menu_options/1` - see "Handling user selection" below.

  ## Persistency

  If you already have a database set up for storing data by session ID, it's a small step to integrate the theme state with it.

  - [Database Session Store with Elixir and Plug (2021)](https://kimlindholm.medium.com/database-session-store-with-elixir-and-plug-4354740e2f58)

  On the other hand, for a lightweight solution you may find caching simpler to start with. For example [Cachex](https://github.com/whitfin/cachex) (which I've selected for [primer-live.org](https://primer-live.org)).

  - [Cachex with Phoenix (2020)](https://www.alenm.com/code/phoenix-cachex)
  - [Use caching to speed up data loading in Phoenix LiveView](https://fullstackphoenix.com/quick_tips/liveview-caching)

  ### Not recommended: Session for theme state

  Using the session to store the theme state (for example [using a AJAX call roundtrip](https://thepugautomatic.com/2020/05/persistent-session-data-in-phoenix-liveview/)) does not work as expected: when navigating to another LiveView page, the updated session data is not refetched and only becomes available after a page refresh.

  ## Handling user selection

  Assuming you are providing a [theme menu](`PrimerLive.Component.theme_menu_options/1`) on the website, the option the user selects must be stored in persistent storage.

  Here we're setting event callback "store_theme" in the theme menu:

  ```
  # Some app component

  <.action_menu>
    <:toggle class="btn btn-invisible">
      <.octicon name="sun-16" />
    </:toggle>
    <.theme_menu_options
      theme_state={@theme_state}
      update_theme_event="store_theme"
    />
  </.action_menu>
  ```

  The callback is invoked whenever a theme menu option is clicked. See attr [`update_theme_event`](`PrimerLive.Component.theme_menu_options/1`) for documentation of the arguments.

  ```
  # App LiveView

  def handle_event(
    "store_theme",
    %{"data" => data, "key" => key, "value" => _},
    socket
  ) do
    # Persist new theme state ...

    {:noreply, socket}
  end
  ```
  """

  use Phoenix.Component

  @default_theme_state %{
    color_mode: "auto",
    light_theme: "light",
    dark_theme: "dark"
  }

  @default_menu_options %{
    color_mode: ~w(light dark auto),
    light_theme: ~w(light light_high_contrast light_colorblind light_tritanopia),
    dark_theme: ~w(dark dark_dimmed dark_high_contrast dark_colorblind dark_tritanopia)
  }

  @default_menu_labels %{
    color_mode: %{
      title: "Theme",
      light: "Light",
      dark: "Dark",
      auto: "System"
    },
    light_theme: %{
      title: "Light tone",
      light: "Light",
      light_high_contrast: "Light high contrast",
      light_colorblind: "Light colorblind",
      light_tritanopia: "Light Tritanopia"
    },
    dark_theme: %{
      title: "Dark tone",
      dark: "Dark",
      dark_dimmed: "Dark dimmed",
      dark_high_contrast: "Dark high contrast",
      dark_colorblind: "Dark colorblind",
      dark_tritanopia: "Dark Tritanopia"
    },
    reset: "Reset to default"
  }

  @update_theme_event_key "update_theme"
  @reset_key "reset"

  @doc ~S"""
  Initial theme state.
  """
  def default_theme_state, do: @default_theme_state

  @doc ~S"""
  Default options for a theme menu.
  """
  def default_menu_options, do: @default_menu_options

  @doc ~S"""
  Default label for a theme menu.
  """
  def default_menu_labels, do: @default_menu_labels

  @doc ~S"""
  Default event name for the `handle_event` update callback.

  This value can be overridden in `theme_menu_options` with `update_theme_event`:
  ```
  <.theme_menu_options
    theme_state={@theme_state}
    update_theme_event="store_theme"
  />
  ```
  """
  def update_theme_event_key, do: @update_theme_event_key

  @doc ~S"""
  Default reset link identifier for the `handle_event` update callback.
  """
  def reset_key, do: @reset_key

  @doc ~S"""
  Configures menu options from supplied params:
  - theme: the current theme state (used to define the selected menu items)
  - menu_options: which menu options will be displayed
  - menu_labels: overrides of default text labels

  Returns a list with 3 menu elements:
  - color_mode
  - dark_theme
  - light_theme

  Each list item is a map that contains display attributes:
  - group label
  - option labels
  - the selected item

  ## Tests

      iex> PrimerLive.Theme.create_menu_items(
      ...> %{
      ...>   color_mode: "light",
      ...>   light_theme: "light_high_contrast",
      ...>   dark_theme: "dark_high_contrast"
      ...> },
      ...> PrimerLive.Theme.default_menu_options(),
      ...> PrimerLive.Theme.default_menu_labels()
      ...> )
      [{:color_mode, %{labeled_options: [{"light", "Light"}, {"dark", "Dark"}, {"auto", "System"}], options: ["light", "dark", "auto"], selected: "light", title: "Theme"}},{:light_theme, %{options: ["light", "light_high_contrast", "light_colorblind", "light_tritanopia"], selected: "light_high_contrast", title: "Light tone", labeled_options: [{"light", "Light"}, {"light_high_contrast", "Light high contrast"}, {"light_colorblind", "Light colorblind"}, {"light_tritanopia", "Light Tritanopia"}]}},{ :dark_theme, %{ labeled_options: [{"dark", "Dark"}, {"dark_dimmed", "Dark dimmed"}, {"dark_high_contrast", "Dark high contrast"}, {"dark_colorblind", "Dark colorblind"}, {"dark_tritanopia", "Dark Tritanopia"}], options: ["dark", "dark_dimmed", "dark_high_contrast", "dark_colorblind", "dark_tritanopia"], selected: "dark_high_contrast", title: "Dark tone" }}]

      iex> PrimerLive.Theme.create_menu_items(
      ...> %{
      ...>   color_mode: "light",
      ...>   light_theme: "light_high_contrast",
      ...>   dark_theme: "dark_high_contrast"
      ...> },
      ...> %{
      ...>   color_mode: ~w(light dark)
      ...> },
      ...> %{
      ...>   color_mode: %{
      ...>     light: "Light theme"
      ...>   },
      ...>   reset: "Reset"
      ...> })
      [color_mode: %{labeled_options: [{"light", "Light theme"}, {"dark", "Dark"}], options: ["light", "dark"], selected: "light", title: "Theme"}]
  """
  def create_menu_items(theme, menu_options, menu_labels) do
    menu_options
    |> Enum.map(&move_options_to_field/1)
    |> Enum.map(&add_selected_state(&1, theme))
    |> Enum.map(&add_labels(&1, menu_labels))
    |> Enum.sort_by(fn {key, _item} ->
      order =
        case key do
          :color_mode -> 0
          :light_theme -> 1
          :dark_theme -> 2
        end

      order
    end)
  end

  defp move_options_to_field({key, options}) do
    {key, %{options: options}}
  end

  defp add_selected_state({key, item_group}, theme) do
    selected = get_in(theme, [Access.key!(key)])
    {key, item_group |> Map.put(:selected, selected)}
  end

  defp add_labels({key, item_group}, menu_labels) do
    merged_labels = Map.merge(default_menu_labels()[key], menu_labels[key] || %{})

    {key,
     item_group
     |> Map.put(
       :labeled_options,
       item_group.options
       |> Enum.map(
         &add_option_label(
           &1,
           merged_labels
         )
       )
     )
     |> Map.put(:title, merged_labels[:title])}
  end

  defp add_option_label(option, group_labels) do
    {option, group_labels[String.to_existing_atom(option)]}
  end

  @doc ~S"""
  Compares the supplied state with the supplied default state.

  ## Tests

      iex> PrimerLive.Theme.default_theme?(
      ...> %{
      ...>   color_mode: "auto",
      ...>   light_theme: "light",
      ...>   dark_theme: "dark"
      ...> },
      ...> PrimerLive.Theme.default_theme_state()
      ...> )
      true

      iex> PrimerLive.Theme.default_theme?(
      ...> %{
      ...>   color_mode: "light",
      ...>   light_theme: "light_high_contrast",
      ...>   dark_theme: "dark_high_contrast"
      ...> },
      ...> PrimerLive.Theme.default_theme_state()
      ...> )
      false
  """
  def default_theme?(theme, default_theme_state) do
    Map.equal?(theme, default_theme_state)
  end

  @doc ~S"""
  Creates HTML (data) attributes from the supplied theme state to set a theme on a component or element directly. This is useful to "theme" specific page parts regardless of the user selected theme, for example a dark page header.

  ```
  <.button
    {PrimerLive.Theme.html_attributes([color_mode: "dark", dark_theme: "dark_high_contrast"])}
  >Button</.button>

  <.octicon name="sun-24"
    {PrimerLive.Theme.html_attributes(%{color_mode: "dark", dark_theme: "dark_dimmed"})}
  />
  ```

  ## Tests

      iex> PrimerLive.Theme.html_attributes(
      ...> %{
      ...>   color_mode: "light",
      ...>   light_theme: "light_high_contrast",
      ...>   dark_theme: "dark_high_contrast"
      ...> }
      ...> )
      [{:"data-color-mode", "light"}, {:"data-dark-theme", "dark_high_contrast"}, {:"data-light-theme", "light_high_contrast"}]

      iex> PrimerLive.Theme.html_attributes(
      ...> %{
      ...> },
      ...> %{
      ...>   color_mode: "auto",
      ...>   light_theme: "light",
      ...>   dark_theme: "dark"
      ...> }
      ...> )
      [{:"data-color-mode", "auto"}, {:"data-dark-theme", "dark"}, {:"data-light-theme", "light"}]

      iex> PrimerLive.Theme.html_attributes(
      ...> %{
      ...>   light_theme: "light_high_contrast",
      ...> },
      ...> %{
      ...>   color_mode: "auto",
      ...>   light_theme: "light",
      ...>   dark_theme: "dark"
      ...> }
      ...> )
      [{:"data-color-mode", "auto"}, {:"data-dark-theme", "dark"}, {:"data-light-theme", "light_high_contrast"}]

      iex> PrimerLive.Theme.html_attributes(
      ...> %{
      ...> },
      ...> %{
      ...>   color_mode: "auto",
      ...> }
      ...> )
      ["data-color-mode": "auto"]
  """

  def html_attributes(theme_state, default_theme_state) do
    data_color_mode = theme_state[:color_mode] || default_theme_state[:color_mode]
    data_light_theme = theme_state[:light_theme] || default_theme_state[:light_theme]
    data_dark_theme = theme_state[:dark_theme] || default_theme_state[:dark_theme]

    PrimerLive.Helpers.AttributeHelpers.append_attributes([
      data_color_mode && ["data-color-mode": data_color_mode],
      data_light_theme && ["data-light-theme": data_light_theme],
      data_dark_theme && ["data-dark-theme": data_dark_theme]
    ])
  end

  @doc """
  See `html_attributes/2`.
  """
  def html_attributes(theme_state), do: html_attributes(theme_state, default_theme_state())
end
