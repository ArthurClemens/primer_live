defmodule PrimerLiveStorybookWeb.SessionController do
  use PrimerLiveStorybookWeb, :controller
  use PrimerLive.ThemeSessionController

  alias PrimerLiveStorybookWeb.NavigationTopicHelpers

  @session_payload_topic_state_key "payload"

  def set_navigation_topic_state(conn, data)
      when is_map_key(data, @session_payload_topic_state_key) do
    store_session(
      conn,
      NavigationTopicHelpers.navigation_topic_state_key(),
      Map.get(data, @session_payload_topic_state_key)
    )
  end

  def set_navigation_topic_state(conn, _data) do
    conn
  end
end
