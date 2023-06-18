defmodule PrimerLiveStorybookWeb.Helpers.StoryPage do
  defmacro __using__(opts) do
    quote do
      use PrimerLiveStorybookWeb, :live_view
      use PrimerLive
      use PrimerLive.ThemeEvent

      import PrimerLiveStorybookWeb.AppComponents

      alias PrimerLiveStorybook.Repo
      alias PrimerLiveStorybookWeb.NavigationTopicHelpers

      @path unquote(Keyword.fetch!(opts, :path))
      @page_title unquote(Keyword.fetch!(opts, :page_title))

      def mount(params, session, socket) do
        socket =
          socket
          |> PrimerLive.Theme.add_to_socket(
            session,
            %{
              color_mode: "light",
              light_theme: "light",
              dark_theme: "dark"
            }
          )
          |> NavigationTopicHelpers.add_to_socket(session)
          |> assign(:page_title, @page_title)
          |> assign(:path, @path)
          |> assign(:changeset, nil)
          |> assign(:ui_changeset, nil)
          |> assign(:page_state, %{})

        {:ok, socket}
      end

      def handle_event("update_ui", _params, socket) do
        {:noreply, socket}
      end

      def handle_event("toggle_state", %{"story-id" => story_id, "key" => key}, socket) do
        %{page_state: page_state} = socket.assigns

        story_state =
          page_state[story_id] ||
            %{
              "source" => false,
              "rendered" => false
            }

        story_state =
          case(key) do
            "source" -> story_state |> Map.put("source", !story_state["source"])
            "rendered" -> story_state |> Map.put("rendered", !story_state["rendered"])
            _ -> story_state
          end

        page_state = page_state |> Map.put(story_id, story_state)

        socket =
          socket
          |> assign(:page_state, page_state)

        {:noreply, socket}
      end
    end
  end
end
