defmodule PrimerLiveStorybookWeb.NavigationTopicHelpers do
  use Phoenix.LiveView

  @navigation_topic_states [
    %{id: "by_name", label: "By name"},
    %{id: "by_topic", label: "By topic"}
  ]

  @default_navigation_topic_state "by_name"
  @navigation_topic_state_key "navigation_topic_state"
  @navigation_topic_state_route "/navigation_topic_state"

  def navigation_topic_state_key(), do: @navigation_topic_state_key
  def navigation_topic_state_route(), do: @navigation_topic_state_route

  def navigation_topic_states(), do: @navigation_topic_states
  def default_navigation_topic_state(), do: @navigation_topic_states |> Enum.at(0) |> Map.get(:id)

  def add_to_socket(socket, session, default_state) do
    socket
    |> assign(
      :navigation_topic_state,
      navigation_topic_state_from_session(session, default_state)
    )
  end

  @doc """
  See `add_to_socket/2`.
  """
  def add_to_socket(socket, session),
    do: add_to_socket(socket, session, default_navigation_topic_state())

  defp navigation_topic_state_from_session(data, default_navigation_topic_state)
       when not is_map_key(data, @navigation_topic_state_key),
       do: default_navigation_topic_state

  defp navigation_topic_state_from_session(
         %{@navigation_topic_state_key => json},
         default_navigation_topic_state
       ) do
    case Jason.decode(json) do
      {:ok, state} ->
        state |> Map.get(navigation_topic_state_key())

      _ ->
        default_navigation_topic_state
    end
  end
end
