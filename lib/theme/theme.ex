defmodule PrimerLive.Theme do
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
  Generic key used for:
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
  def session_route(), do: "/#{@session_key}"

  @doc ~S"""
  Theme data stored in the session.
  """
  def session_theme_key(), do: @session_theme_key

  @doc ~S"""
  Reset link identifier to distinguish in update.
  """
  def reset_key(), do: @reset_key
  def update_theme_event_key(), do: @update_theme_event_key
  def default_theme_state(), do: @default_theme_state
  def default_menu_options(), do: @default_menu_options
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

  ## Examples

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
    merged_labels = Map.merge(@default_menu_labels[key], menu_labels[key] || %{})

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

  ## Examples

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
  Adds theme_state and default_theme_state to the socket.assigns.
  """
  def add_to_socket(socket, session, default_theme_state) do
    socket
    |> assign(:theme_state, theme_state_from_session(session, default_theme_state))
    |> assign(:default_theme_state, default_theme_state)
  end

  def add_to_socket(socket, session), do: add_to_socket(socket, session, @default_theme_state)

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
  Creates HTML (data) attributes from the supplied theme state.

  ## Examples

      iex> PrimerLive.Theme.html_attributes(
      ...> %{
      ...>   color_mode: "light",
      ...>   light_theme: "light_high_contrast",
      ...>   dark_theme: "dark_high_contrast"
      ...> }
      ...> )
      [data_color_mode: "light", data_light_theme: "light_high_contrast", data_dark_theme: "dark_high_contrast"]

      iex> PrimerLive.Theme.html_attributes(
      ...> %{
      ...> },
      ...> %{
      ...>   color_mode: "auto",
      ...>   light_theme: "light",
      ...>   dark_theme: "dark"
      ...> }
      ...> )
      [data_color_mode: "auto", data_light_theme: "light", data_dark_theme: "dark"]

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
      [data_color_mode: "auto", data_light_theme: "light_high_contrast", data_dark_theme: "dark"]

      iex> PrimerLive.Theme.html_attributes(
      ...> %{
      ...> },
      ...> %{
      ...>   color_mode: "auto",
      ...> }
      ...> )
      [data_color_mode: "auto"]
  """

  def html_attributes(theme_state, default_theme_state) do
    data_color_mode = theme_state[:color_mode] || default_theme_state[:color_mode]
    data_light_theme = theme_state[:light_theme] || default_theme_state[:light_theme]
    data_dark_theme = theme_state[:dark_theme] || default_theme_state[:dark_theme]

    PrimerLive.Helpers.AttributeHelpers.append_attributes([
      data_color_mode && [data_color_mode: data_color_mode],
      data_light_theme && [data_light_theme: data_light_theme],
      data_dark_theme && [data_dark_theme: data_dark_theme]
    ])
  end

  def html_attributes(theme_state), do: html_attributes(theme_state, @default_theme_state)
end
