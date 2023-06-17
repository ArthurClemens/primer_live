defmodule PrimerLiveTestWeb.ButtonLive do
  use PrimerLiveTestWeb, :live_view
  use Phoenix.Component

  use PrimerLive
  import PrimerLiveTestWeb.TestComponents

  def render(assigns) do
    tests = [
      %{title: "Variants", test_fn: &test_variants/1},
      %{title: "Selected", test_fn: &test_is_selected/1},
      %{title: "Small", test_fn: &test_is_small/1},
      %{title: "Large", test_fn: &test_is_large/1}
    ]

    assigns =
      assigns
      |> assign(:tests, tests)

    ~H"""
    <.test_page tests={@tests} title="button" />
    """
  end

  defp test_variants(assigns) do
    ~H"""
    <.variants test_id="variants" />
    """
  end

  defp test_is_selected(assigns) do
    ~H"""
    <.variants test_id="is_selected" is_selected />
    """
  end

  defp test_is_small(assigns) do
    ~H"""
    <.variants test_id="is_small" is_small />
    """
  end

  defp test_is_large(assigns) do
    ~H"""
    <.variants test_id="is_large" is_large />
    """
  end

  attr(:test_id, :string, required: true)
  attr(:is_selected, :boolean, default: false)
  attr(:is_small, :boolean, default: false)
  attr(:is_large, :boolean, default: false)

  defp variants(assigns) do
    ~H"""
    <div style="display: flex; flex-wrap: wrap; gap: 8px; align-items: baseline;">
      <span data-testid={slugify([@test_id, "plain"])}>
        <.button is_selected={@is_selected} is_small={@is_small} is_large={@is_large}>Plain</.button>
      </span>
      <span data-testid={slugify([@test_id, "outline"])}>
        <.button is_selected={@is_selected} is_small={@is_small} is_large={@is_large} is_outline>Outline</.button>
      </span>
      <span data-testid={slugify([@test_id, "primary"])}>
        <.button is_selected={@is_selected} is_small={@is_small} is_large={@is_large} is_primary>Primary</.button>
      </span>
      <span data-testid={slugify([@test_id, "danger"])}>
        <.button is_selected={@is_selected} is_small={@is_small} is_large={@is_large} is_danger>Danger</.button>
      </span>
      <span data-testid={slugify([@test_id, "invisible"])}>
        <.button is_selected={@is_selected} is_small={@is_small} is_large={@is_large} is_invisible>Invisible</.button>
      </span>
      <span data-testid={slugify([@test_id, "disabled"])}>
        <.button is_selected={@is_selected} is_small={@is_small} is_large={@is_large} is_disabled>Disabled</.button>
      </span>
    </div>
    """
  end
end
