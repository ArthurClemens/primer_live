defmodule PrimerLive.Helpers.Schema do
  import Phoenix.LiveView.Helpers

  @moduledoc false

  @doc ~S"""
  Fetches the schema keys minus the private fields `__struct__` and `__meta__`.

  ## Examples

      iex> PrimerLive.Helpers.Schema.get_keys(PrimerLive.Options.Pagination)
      [:boundary_count, :class, :classes, :current_page, :is_numbered, :labels, :link_options, :link_path, :page_count, :sibling_count]
  """
  def get_keys(module) do
    module.__struct__()
    |> Map.drop([:__struct__, :__meta__])
    |> Map.keys()
  end

  @doc ~S"""
  Renders a locally defined LiveView component `invalid_schema_message` to show changeset errors in a readable format.

  ## Examples

      iex> import Phoenix.LiveViewTest, only: [rendered_to_string: 1]
      iex> import PrimerLive.Helpers.TestHelpers, only: [format_html: 1]
      iex> %PrimerLive.Options.Pagination{page_count: 1, current_page: 1, link_path: nil} |> PrimerLive.Options.Pagination.changeset() |> PrimerLive.Helpers.Schema.show_errors("Pagination") |> rendered_to_string() |> format_html()
      "<div class=\"flash flash-error\"><p>Pagination component received invalid options:</p><p>link_path: can&#39;t be blank</p></div>"
  """
  def show_errors(changeset, component_name) do
    invalid_schema_message(%{
      changeset: changeset,
      component_name: component_name
    })
  end

  defp invalid_schema_message(assigns) do
    errors =
      Ecto.Changeset.traverse_errors(assigns.changeset, fn {msg, opts} ->
        Regex.replace(~r"%{(\w+)}", msg, fn _, key ->
          opts |> Keyword.get(String.to_existing_atom(key), key) |> to_string()
        end)
      end)

    ~H"""
    <.error_message component_name={@component_name}>
      <%= for {option_name, messages} <- errors do %>
        <%= for message <- messages do %>
          <p><%= option_name %>: <%= message %></p>
        <% end %>
      <% end %>
    </.error_message>
    """
  end

  @doc false
  def error_message(assigns) do
    ~H"""
    <div class="flash flash-error">
      <p><%= @component_name %> component received invalid options:</p>
      <%= render_slot(@inner_block) %>
    </div>
    """
  end
end
