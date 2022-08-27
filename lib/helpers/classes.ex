defmodule PrimerLive.Helpers.Classes do
  @moduledoc false

  @doc ~S"""
  Concatenates a list of classnames to a single string.
  - Ignores any nil list values
  - Removes duplicate entries
  - Trims whitespaces
  Returns nil if the resulting output is an empty string.

  ## Examples

      iex> PrimerLive.Helpers.Classes.join_classnames([])
      nil

      iex> PrimerLive.Helpers.Classes.join_classnames([""])
      nil

      iex> PrimerLive.Helpers.Classes.join_classnames(["foo   ", nil, "  bar  "])
      "foo bar"

      iex> PrimerLive.Helpers.Classes.join_classnames(["foo", nil, "  foo  "])
      "foo"
  """
  def join_classnames(list) do
    result =
      list
      |> Enum.reject(&is_nil(&1))
      |> Enum.map(&String.trim(&1))
      |> Enum.uniq()
      |> Enum.join(" ")

    if result == "" do
      nil
    else
      result
    end
  end
end
