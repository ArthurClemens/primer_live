defmodule PrimerLive.Helpers.TestHelpers do
  @moduledoc false

  @doc ~S"""
  Tweaks Phoenix.LiveView.HTMLFormatter.format/2 to remove spaces surrounding HTML tags.

  ## Examples

      iex> PrimerLive.Helpers.TestHelpers.format_html("
      ...>   <div> <span>Content</span>
      ...>   </div>
      ...>             ")
      "<div><span>Content</span></div>"
  """
  def format_html(html) do
    html
    |> Phoenix.LiveView.HTMLFormatter.format([])
    |> String.replace(~r/\n/, " ")
    |> String.replace(~r/\s+/, " ")
    |> String.replace(~r/\"\s>/, "\">")
    |> String.replace(~r/>\s</, "><")
    |> String.trim()
  end
end
