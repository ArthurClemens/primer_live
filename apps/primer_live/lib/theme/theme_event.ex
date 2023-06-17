defmodule PrimerLive.ThemeEvent do
  @moduledoc """
  Handles update events from a theme menu. Usage instructions: see `PrimerLive.Theme`.
  """

  defmacro __using__(_) do
    quote do
      alias PrimerLive.Theme

      @update_theme_event_key Theme.update_theme_event_key()

      @doc ~S"""
      Update theme data from the event detail, add it to the socket assigns, and send it as a new event to be picked up by JavaScript.
      """
      def handle_event(
            @update_theme_event_key,
            detail,
            socket
          ) do
        %{theme_state: theme_state, default_theme_state: default_theme_state} = socket.assigns

        new_theme_state = Theme.update(theme_state, detail, default_theme_state)

        socket =
          socket
          |> assign(:theme_state, new_theme_state)
          # Send to JavaScript:
          |> push_event(
            Theme.session_key(),
            new_theme_state
          )

        {:noreply, socket}
      end
    end
  end
end
