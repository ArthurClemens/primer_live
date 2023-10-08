defmodule PrimerLive.Helpers.TestHelpers do
  @moduledoc false

  @doc ~S"""
  Tweaks Phoenix.LiveView.HTMLFormatter.format/2 to remove spaces surrounding HTML tags.

  ## Tests

      iex> PrimerLive.Helpers.TestHelpers.format_html("
      ...>   <div> <span>Content</span>
      ...>   </div>
      ...>             ")
      "<div><span>Content</span></div>"

      iex> PrimerLive.Helpers.TestHelpers.format_html("
      ...>   <button class=\"btn\" type=\"submit\"> Button </button>")
      "<button class=\"btn\" type=\"submit\">Button</button>"
  """
  def format_html(html) do
    html
    |> Phoenix.LiveView.HTMLFormatter.format([])
    |> String.replace(~r/\s*\n\s*/, " ")
    |> String.replace(~r/\s*\<\s*/, "<")
    |> String.replace(~r/\s*\>\s*/, ">")
    |> String.replace(~r/<(path|circle) .*?<\/(path|circle)>/, "STRIPPED_SVG_PATHS")
    |> String.replace(~r/STRIPPED_SVG_PATHSSTRIPPED_SVG_PATHS/, "STRIPPED_SVG_PATHS")
    |> String.trim()
  end
end

defmodule PrimerLive.Helpers.TestForm do
  @moduledoc false

  defstruct source: nil, name: nil
end
