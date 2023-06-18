defmodule PrimerLiveStorybookWeb.ButtonLive do
  use PrimerLiveStorybookWeb.Helpers.StoryPage,
    page_title: "Button",
    path: "/button"

  def handle_params(_params, _url, socket) do
    {:noreply, socket}
  end

  def render(assigns) do
    assigns =
      assigns
      |> assign(:stories, [
        %{title: "Variants", story_fn: &story_variants/1},
        %{title: "Selected", story_fn: &story_selected/1},
        %{title: "Small", story_fn: &story_small/1}
      ])
      |> assign(:story_doc_components, [
        "button",
        "button_group"
      ])

    ~H"""
    <.story_page
      page_title={@page_title}
      path={@path}
      theme_state={@theme_state}
      default_theme_state={@default_theme_state}
      navigation_topic_state={@navigation_topic_state}
      ui_changeset={@ui_changeset}
    >
      <.story_page_content
        page_title={@page_title}
        path={@path}
        story_doc_components={@story_doc_components}
        stories={@stories}
        page_state={@page_state}
        navigation_topic_state={@navigation_topic_state}
      />
    </.story_page>
    """
  end

  defp story_variants(assigns) do
    ~H"""
    <.story
    page_state={@page_state}
    path={@path}
    title={@title}
    raw={~S'''
    <div style="display: flex; flex-wrap: wrap; gap: 8px; align-items: baseline;">
      <.button>Plain</.button>
      <.button is_outline>Outline</.button>
      <.button is_primary>Primary</.button>
      <.button is_danger>Danger</.button>
      <.button is_invisible>Invisible</.button>
      <.button is_disabled>Disabled</.button>
    </div>
    '''}>
    <div style="display: flex; flex-wrap: wrap; gap: 8px; align-items: baseline;">
      <.button>Plain</.button>
      <.button is_outline>Outline</.button>
      <.button is_primary>Primary</.button>
      <.button is_danger>Danger</.button>
      <.button is_invisible>Invisible</.button>
      <.button is_disabled>Disabled</.button>
    </div>
    </.story>
    """
  end

  defp story_selected(assigns) do
    ~H"""
    <.story
    page_state={@page_state}
    path={@path}
    title={@title}
    raw={~S'''
    <div style="display: flex; flex-wrap: wrap; gap: 8px; align-items: baseline;">
      <.button is_selected>Plain</.button>
      <.button is_outline is_selected>Outline</.button>
      <.button is_primary is_selected>Primary</.button>
      <.button is_danger is_selected>Danger</.button>
      <.button is_invisible is_selected>Invisible</.button>
      <.button is_disabled is_selected>Disabled</.button>
    </div>
    '''}>
    <div style="display: flex; flex-wrap: wrap; gap: 8px; align-items: baseline;">
      <.button is_selected>Plain</.button>
      <.button is_outline is_selected>Outline</.button>
      <.button is_primary is_selected>Primary</.button>
      <.button is_danger is_selected>Danger</.button>
      <.button is_invisible is_selected>Invisible</.button>
      <.button is_disabled is_selected>Disabled</.button>
    </div>
    </.story>
    """
  end

  defp story_small(assigns) do
    ~H"""
    <.story
    page_state={@page_state}
    path={@path}
    title={@title}
    raw={~S'''
    <div style="display: flex; flex-wrap: wrap; gap: 8px; align-items: baseline;">
      <.button is_small>Plain</.button>
      <.button is_small is_outline>Outline</.button>
      <.button is_small is_primary>Primary</.button>
      <.button is_small is_danger>Danger</.button>
      <.button is_small is_invisible>Invisible</.button>
      <.button is_small is_disabled>Disabled</.button>
    </div>
    '''}>
    <div style="display: flex; flex-wrap: wrap; gap: 8px; align-items: baseline;">
      <.button is_small>Plain</.button>
      <.button is_small is_outline>Outline</.button>
      <.button is_small is_primary>Primary</.button>
      <.button is_small is_danger>Danger</.button>
      <.button is_small is_invisible>Invisible</.button>
      <.button is_small is_disabled>Disabled</.button>
    </div>
    </.story>
    """
  end
end
