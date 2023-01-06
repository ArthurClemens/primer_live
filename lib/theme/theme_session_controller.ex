defmodule PrimerLive.ThemeSessionController do
  defmacro __using__(_) do
    quote do
      alias PrimerLive.Theme

      @theme_session_key Theme.session_key()

      @doc ~S"""
      Capture theme request and store the theme data in the session.
      """
      def set(conn, data) when is_map_key(data, @theme_session_key),
        do: store_theme(conn, :theme, Map.get(data, @theme_session_key))

      defp store_theme(conn, key, value) do
        conn
        |> put_session(key, value)
        |> json("ok")
      end
    end
  end
end
