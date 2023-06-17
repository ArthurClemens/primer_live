defmodule PrimerLiveTestWeb.TestComponents do
  use PrimerLive
  use Phoenix.Component

  attr(:title, :string, required: true)
  attr(:tests, :list, required: true)
  attr(:changeset, :map, default: nil)

  def test_page(assigns) do
    ~H"""
    <h1 class="text-3xl font-medium"><%= @title %></h1>
    <div class="mt-5 grid gap-5">
      <%= for %{title: test_title, test_fn: test_fn} <- @tests do %>
        <div>
          <h2 class="text-base mt-3"><%= test_title %></h2>
          <div class="mt-3" data-testid={slugify([@title, test_title])}>
            <%= test_fn.(Map.merge(assigns, %{changeset: @changeset})) %>
          </div>
        </div>
      <% end %>
    </div>
    """
  end

  def slugify(parts) do
    Slug.slugify(Enum.join(parts, "-")) |> String.replace("_", "-")
  end
end
