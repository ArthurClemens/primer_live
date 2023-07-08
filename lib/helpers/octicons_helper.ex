defmodule PrimerLive.Helpers.OcticonsHelper do
  @moduledoc false
  # Processes icon files from https://github.com/primer/octicons and writes the SVG data to `lib/octicons.ex`.
  # Called by `priv/octicon_builder/build.exs`.

  require EEx

  @priv_path "priv/octicon_builder"
  @module_path "lib/octicons.ex"
  @story_list_path "#{@priv_path}/story_list.ex"

  EEx.function_from_string(
    :defp,
    :module_wrapper,
    """
    defmodule PrimerLive.Octicons do
      use Phoenix.Component

      # Generated by PrimerLive.Helpers.OcticonsHelper

      @doc \"\"\"
      Internal use: generates a map of SVG's.

      To use the `PrimerLive.Component.octicon/1` component, write:
      ```
      <.octicon name="icon-name" />
      ```

      ## All octicons

      ```
      <%= for %{name: name} <- icons do %><.octicon name="<%= name %>" />
      <% end %>```
      \"\"\"

      def octicons(assigns) do
        %{
          <%= for %{name: name, svg: svg} <- icons do %>
          "<%= name %>" => ~H\"\"\"
          <%= svg %>
          \"\"\",<% end %>
        }
      end

    end
    """,
    [:icons]
  )

  EEx.function_from_string(
    :defp,
    :story_list,
    """
    stories = [
      <%= for %{name: name} <- icons do %>%{title: "<%= name %>", story_fn: &icon_story/1},
      <% end %>]
    """,
    [:icons]
  )

  def build(dirname) do
    icons_path = "#{@priv_path}/#{dirname}/icons"

    with {:ok, filenames} <- File.ls(icons_path),
         {:ok, _count} <- file_count(filenames) do
      icons =
        filenames
        |> Enum.map(
          &%{
            svg:
              File.read!("#{icons_path}/#{&1}")
              |> String.replace(~r/\<svg/, "<svg class={@class} {@rest}"),
            name: &1 |> String.replace(".svg", "")
          }
        )
        |> Enum.sort_by(& &1[:name])

      result = module_wrapper(icons)

      case File.write(@module_path, result) do
        :ok ->
          IO.puts("PrimerLive.Octicons module written")

        error ->
          IO.puts("Error writing PrimerLive.Octicons module")
          error
      end

      story_list_result = story_list(icons)

      case File.write(@story_list_path, story_list_result) do
        :ok ->
          IO.puts("Story list written")

        error ->
          IO.puts("Error writing story list")
          error
      end
    else
      {:error, :enoent} ->
        IO.puts("Could not read directory '#{icons_path}'. Does this directory exist?")

      {:error, :empty} ->
        IO.puts("Could not proceed: directory '#{icons_path}' is empty.")
    end
  end

  defp file_count(filenames) do
    case Enum.count(filenames) do
      0 -> {:error, :empty}
      count -> {:ok, count}
    end
  end
end