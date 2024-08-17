defmodule PrimerLive.StatefulConditionComponent do
  @moduledoc """
  A wrapper component that takes a condition and compares the initial state with the current state after a re-render.
  This is useful when the wrapped component should behave differently on initial mount and subsequent updates.

  ## Examples

  In this example, the 'Create new post' dialog is shown when `@live_action` is `:new`.
  When triggered from the posts listing, the dialog appears with a fade-in effect.
  If the page is reloaded while still on that route, the dialog is shown immediately
  using the dialog attribute `is_show_on_mount`.

          <.live_component
            id="create-post-dialog-component"
            module={PrimerLive.StatefulConditionComponent}
            condition={@live_action == :new || nil}
            :let={
              %{
                equals_initial_condition: equals_initial_condition,
                condition: condition
              }
            }
          >
            <.dialog id="create-post"
              :if={condition}
              is_show
              is_show_on_mount={equals_initial_condition}
              on_cancel={JS.patch(~p"/posts")}
            >
              ...
            </.dialog>
          </.live_component>
  """
  use Phoenix.LiveComponent

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <%= render_slot(@inner_block, %{
        equals_initial_condition: @equals_initial_condition,
        condition: @condition
      }) %>
    </div>
    """
  end

  @impl true
  def update(assigns, socket) do
    initial_condition = get_initial_condition(assigns, socket)

    socket =
      socket
      |> assign(assigns)
      |> assign(:initial_condition, initial_condition)
      |> assign(:equals_initial_condition, initial_condition == assigns[:condition])

    {:ok, socket}
  end

  defp get_initial_condition(%{condition: condition} = _assigns, _socket)
       when is_nil(condition),
       do: :unset

  defp get_initial_condition(assigns, socket) do
    socket.assigns[:initial_condition] || assigns[:condition] || :unset
  end
end
