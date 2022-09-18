defmodule PrimerLive.Helpers.Attributes do
  @moduledoc false

  @doc ~S"""
  Concatenates a list of classnames to a single string.
  - Ignores any nil or false entries
  - Removes duplicate entries
  - Trims whitespaces
  Returns nil if the resulting output is an empty string.

  ## Examples

      iex> PrimerLive.Helpers.Attributes.classnames([])
      nil

      iex> PrimerLive.Helpers.Attributes.classnames([""])
      nil

      iex> PrimerLive.Helpers.Attributes.classnames(["foo   ", nil, "  bar  ", false])
      "foo bar"

      iex> PrimerLive.Helpers.Attributes.classnames(["foo", nil, "  foo  "])
      "foo"

      iex> is_foo = true
      iex> is_bar = false
      iex> PrimerLive.Helpers.Attributes.classnames([
      ...>   is_foo and "foo",
      ...>   is_bar and "bar"
      ...> ])
      "foo"
  """
  def classnames(input_classnames) do
    result =
      input_classnames
      |> Enum.reject(&(is_nil(&1) || &1 == false || &1 == ""))
      |> Enum.map(&String.trim(&1))
      |> Enum.uniq()
      |> Enum.join(" ")

    if result == "" do
      nil
    else
      result
    end
  end

  @doc ~S"""
  Concatenates 2 keyword lists of attributes.
  - Ignores any nil or false entries
  - Removes duplicate entries

  ## Examples

      iex> PrimerLive.Helpers.Attributes.append_attributes([], [[]])
      []

      iex> PrimerLive.Helpers.Attributes.append_attributes([dir: "rtl"], [[]])
      [dir: "rtl"]

      iex> PrimerLive.Helpers.Attributes.append_attributes([dir: "rtl"], [[placeholder: "hello"]])
      [dir: "rtl", placeholder: "hello"]

      iex> PrimerLive.Helpers.Attributes.append_attributes([dir: "rtl"], [false, [placeholder: "hello"], [placeholder: "hello"], nil])
      [dir: "rtl", placeholder: "hello"]

      iex> is_foo = true
      iex> is_bar = false
      iex> extra = [class: "x"]
      iex> PrimerLive.Helpers.Attributes.append_attributes(extra, [
      ...>   is_foo and [foo: "foo"],
      ...>   is_bar and [bar: "bar"]
      ...> ])
      [class: "x", foo: "foo"]
  """
  def append_attributes(attributes, input_attributes) do
    new_attributes =
      input_attributes
      |> Enum.reject(&(&1 == false || is_nil(&1)))
      |> Enum.uniq()

    new_attributes
    |> Enum.reduce(attributes, fn kw, acc ->
      acc ++ kw
    end)
  end

  @aria_attributes_map %{
    is_selected: ["aria-selected": "true"],
    is_disabled: ["aria-disabled": "true"]
  }

  @doc ~S'''
  Creates an "aria attributes" keyword list from an input keyword list with component values.

  ## Examples

      iex> PrimerLive.Helpers.Attributes.get_aria_attributes([])
      []

      iex> PrimerLive.Helpers.Attributes.get_aria_attributes(is_selected: true)
      ["aria-selected": "true"]

      iex> PrimerLive.Helpers.Attributes.get_aria_attributes(is_selected: true, is_disabled: true)
      ["aria-selected": "true", "aria-disabled": "true"]
  '''
  def get_aria_attributes(input_attribute_values) do
    input_attribute_values
    |> Enum.filter(fn {_k, v} -> !!v end)
    |> Enum.reduce([], fn {k, _v}, acc -> acc ++ Map.get(@aria_attributes_map, k) end)
  end

  @doc ~S"""
  Converts user input to an integer, with optionally a default value

  ## Examples

      iex> PrimerLive.Helpers.Attributes.as_integer("1")
      1

      iex> PrimerLive.Helpers.Attributes.as_integer(2)
      2

      iex> PrimerLive.Helpers.Attributes.as_integer(2.0)
      2

      iex> PrimerLive.Helpers.Attributes.as_integer("x")
      nil

      iex> PrimerLive.Helpers.Attributes.as_integer("x", 42)
      42
  """
  def as_integer(input, default_value \\ nil) do
    cond do
      is_integer(input) ->
        input

      is_binary(input) ->
        try do
          String.to_integer(input)
        rescue
          ArgumentError -> default_value
        end

      is_float(input) ->
        trunc(input)

      is_number(input) ->
        case Integer.parse(input) do
          :error ->
            default_value

          {value, _rest} ->
            value
        end

      true ->
        default_value
    end
  end

  @doc """
  Takes 2 lists and padds the shortest list with placeholder values.

  ## Examples

      iex> PrimerLive.Helpers.Attributes.pad_lists([], [])
      [[], []]

      iex> PrimerLive.Helpers.Attributes.pad_lists([1, 2, 3], [])
      [[1, 2, 3], [:placeholder, :placeholder, :placeholder]]

      iex> PrimerLive.Helpers.Attributes.pad_lists([], [1, 2, 3])
      [[:placeholder, :placeholder, :placeholder], [1, 2, 3]]

      iex> PrimerLive.Helpers.Attributes.pad_lists([1], [1, 2])
      [[1, :placeholder], [1, 2]]

      iex> PrimerLive.Helpers.Attributes.pad_lists([], [1, 2, 3], 0)
      [[0, 0, 0], [1, 2, 3]]

      iex> header_slot = []
      iex> header_title_slot = [%{
      ...>   __slot__: :header_title,
      ...>   inner_block: "Title content"
      ...> }]
      iex> Enum.zip(PrimerLive.Helpers.Attributes.pad_lists(header_slot, header_title_slot, []))
      [{[], %{__slot__: :header_title, inner_block: "Title content"}}]

  """
  def pad_lists(list1, list2, padding \\ :placeholder) do
    case Enum.count(list1) > Enum.count(list2) do
      true ->
        [
          list1,
          pad_list(list1, list2, padding)
        ]

      false ->
        [
          pad_list(list2, list1, padding),
          list2
        ]
    end
  end

  defp pad_list(longest, shortest, padding) do
    longest
    |> Enum.with_index()
    |> Enum.map(fn {_, idx} -> Enum.at(shortest, idx) || padding end)
  end
end
