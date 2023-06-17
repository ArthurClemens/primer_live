defmodule PrimerLive.Theme do
  @moduledoc """
  Primer CSS contains styles for light/dark color modes and themes, with support for color blindness.

  PrimerLive provides components and functions to work with themes:
  - [`theme/1`](`PrimerLive.Component.theme/1`) - wrapper to set the theme on child elements
  - [`theme_menu_options/1`](`PrimerLive.Component.theme_menu_options/1`) - contents for a theme menu
  - `html_attributes/2` - HTML attributes to set a theme on a component or element directly

  ## Persistency

  There is no easy way to save persistent session data in LiveView because LiveView's state is stored in a process that ends when the page is left. The solution is to use an Ajax request to our Phoenix app, which updates the session.

  This setup involves 5 steps, but the provided helper functions make it a bit easier.


  ### 1. Create a SessionController

  Create file `controllers/session_controller.ex`:

  ```
  defmodule MyAppWeb.SessionController do
    use MyAppWeb, :controller
    use PrimerLive.ThemeSessionController
  end
  ```

  `PrimerLive.ThemeSessionController` will add the received theme request data to the session.


  ### 2. Add SessionController to the router's api

  ```
  scope "/api", MyAppWeb do
    pipe_through :api

    post PrimerLive.Theme.session_route(), SessionController, :set
  end
  ```

  Optionally set the `max_age` in `endpoint.ex`:

  ```
  @session_options [
    ...
    # Over 300 years.
    max_age: 9_999_999_999
  ]
  ```

  ### 3. Add the Theme hook

  In `app.js`, import `Theme` and add it to the `liveSocket` hooks:

  ```
  import { Prompt, Theme } from 'primer-live';

  const hooks = {};
  hooks.Prompt = Prompt;
  hooks.Theme = Theme;

  let liveSocket = new LiveSocket('/live', Socket, {
    params: { _csrf_token: csrfToken },
    hooks,
  });
  ```

  You may the hook anywhere, but only once for the entire application. If you have a single theme menu, add it there:

  ```
  <.action_menu phx-hook="Theme" id="theme_menu">
  ...
  </.action_menu>
  ```

  ### 4. Initialise the theme from session data

  In the LiveView's `mount`, call `add_to_socket`:

  ```
  def mount(_params, session, socket) do
    socket =
      socket
      |> PrimerLive.Theme.add_to_socket(session)

    {:ok, socket}
  end
  ```

  This reads the theme state and adds it to the socket assigns.

  Optionally set the default theme in the seconds argument:

  ```
  PrimerLive.Theme.add_to_socket(session, %{
    color_mode: "light",
    light_theme: "light",
    dark_theme: "dark"
  })
  ```

  ### 5. Handle update events

  In the LiveView where the action menu resides, add:

  ```
  use PrimerLive.ThemeEvent
  ```

  This implements function `handle_event` for "update_theme" (which is called by clicks on the menu's `action_list` items).
  The function updates the socket and sends the event that is picked by by JavaScript (via the `Theme` hook).
  """

  use Phoenix.Component

  @session_key "pl-session"
  @session_theme_key "theme"
  @reset_key "reset"
  @update_theme_event_key "update_theme"

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

  @doc ~S"""
  Generic key.

  Used for:
  - session route
  - JS event name ("phx:" prefix is assigned automatically)
  """
  def session_key(), do: @session_key

  @doc ~S"""
  Route for session api calls.

  For example:
  ```
  scope "/api", MyAppWeb do
    pipe_through :api

    post PrimerLive.Theme.session_route(), SessionController, :set
  end
  ```
  """
  def session_route(), do: "/#{session_key()}"

  @doc ~S"""
  Theme data stored in the session.
  """
  def session_theme_key(), do: @session_theme_key

  @doc ~S"""
  Internal use.
  Reset link identifier to distinguish in update.
  """
  def reset_key(), do: @reset_key

  @doc ~S"""
  Internal use.
  Update link identifier.
  """
  def update_theme_event_key(), do: @update_theme_event_key

  @doc ~S"""
  Initial theme state.
  """
  def default_theme_state(), do: @default_theme_state

  @doc ~S"""
  Default options for a theme menu.
  """
  def default_menu_options(), do: @default_menu_options

  @doc ~S"""
  Default label for a theme menu.
  """
  def default_menu_labels(), do: @default_menu_labels

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
      [color_mode: %{labeled_options: [{"light", "Light"}, {"dark", "Dark"}, {"auto", "System"}], options: ["light", "dark", "auto"], selected: "light", title: "Theme"}, dark_theme: %{labeled_options: [{"dark", "Dark"}, {"dark_dimmed", "Dark dimmed"}, {"dark_high_contrast", "Dark high contrast"}, {"dark_colorblind", "Dark colorblind"}, {"dark_tritanopia", "Dark Tritanopia"}], options: ["dark", "dark_dimmed", "dark_high_contrast", "dark_colorblind", "dark_tritanopia"], selected: "dark_high_contrast", title: "Dark tone"}, light_theme: %{labeled_options: [{"light", "Light"}, {"light_high_contrast", "Light high contrast"}, {"light_colorblind", "Light colorblind"}, {"light_tritanopia", "Light Tritanopia"}], options: ["light", "light_high_contrast", "light_colorblind", "light_tritanopia"], selected: "light_high_contrast", title: "Light tone"}]

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

      iex> PrimerLive.Theme.is_default_theme(
      ...> %{
      ...>   color_mode: "auto",
      ...>   light_theme: "light",
      ...>   dark_theme: "dark"
      ...> },
      ...> PrimerLive.Theme.default_theme_state()
      ...> )
      true

      iex> PrimerLive.Theme.is_default_theme(
      ...> %{
      ...>   color_mode: "light",
      ...>   light_theme: "light_high_contrast",
      ...>   dark_theme: "dark_high_contrast"
      ...> },
      ...> PrimerLive.Theme.default_theme_state()
      ...> )
      false
  """
  def is_default_theme(theme, default_theme_state) do
    Map.equal?(theme, default_theme_state)
  end

  @doc ~S"""
  Adds `theme_state` and `default_theme_state` to `socket.assigns`.
  """
  def add_to_socket(socket, session, default_theme_state) do
    socket
    |> assign(:theme_state, theme_state_from_session(session, default_theme_state))
    |> assign(:default_theme_state, default_theme_state)
  end

  @spec add_to_socket(map, map) :: map
  @doc """
  See `add_to_socket/3`.
  """
  def add_to_socket(socket, session), do: add_to_socket(socket, session, default_theme_state())

  defp theme_state_from_session(data, default_theme_state)
       when not is_map_key(data, @session_theme_key),
       do: default_theme_state

  defp theme_state_from_session(%{@session_theme_key => json}, default_theme_state) do
    case Jason.decode(json) do
      {:ok, theme} -> theme |> Map.new(fn {k, v} -> {String.to_existing_atom(k), v} end)
      _ -> default_theme_state
    end
  end

  @doc ~S"""
  Returns an updated theme state by putting the supplied data in the theme state.
  If key is the reset key, returns the default theme state.
  """
  def update(
        _theme_state,
        %{"key" => @reset_key, "data" => _data},
        default_theme_state
      ),
      do: default_theme_state

  def update(theme_state, %{"key" => key, "data" => data}, _default_theme_state) do
    Map.put(theme_state, String.to_existing_atom(key), data)
  end

  @doc ~S"""
  Creates HTML (data) attributes from the supplied theme state to set a theme on a component or element directly:

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
      ["data-color-mode": "light", "data-light-theme": "light_high_contrast", "data-dark-theme": "dark_high_contrast"]

      iex> PrimerLive.Theme.html_attributes(
      ...> %{
      ...> },
      ...> %{
      ...>   color_mode: "auto",
      ...>   light_theme: "light",
      ...>   dark_theme: "dark"
      ...> }
      ...> )
      ["data-color-mode": "auto", "data-light-theme": "light", "data-dark-theme": "dark"]

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
      ["data-color-mode": "auto", "data-light-theme": "light_high_contrast", "data-dark-theme": "dark"]

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
