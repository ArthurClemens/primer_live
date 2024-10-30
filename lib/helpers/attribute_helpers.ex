defmodule PrimerLive.Helpers.AttributeHelpers do
  @moduledoc false

  use Phoenix.Component
  alias Phoenix.LiveView.JS
  alias PrimerLive.Helpers.{ComponentHelpers, FormHelpers, PromptHelpers}

  @doc ~S"""
  Concatenates a list of classnames to a single string.
  - Ignores any nil or false entries
  - Removes duplicate entries
  - Trims whitespaces
  Returns nil if the resulting output is an empty string.

  ## Tests

      iex> PrimerLive.Helpers.AttributeHelpers.classnames([])
      nil

      iex> PrimerLive.Helpers.AttributeHelpers.classnames([""])
      nil

      iex> PrimerLive.Helpers.AttributeHelpers.classnames(["foo   ", nil, "  bar  ", false])
      "foo bar"

      iex> PrimerLive.Helpers.AttributeHelpers.classnames(["foo", nil, "  foo  "])
      "foo"

      iex> is_foo = true
      iex> is_bar = false
      iex> PrimerLive.Helpers.AttributeHelpers.classnames([
      ...>   is_foo and "foo",
      ...>   is_bar and "bar"
      ...> ])
      "foo"

      iex> PrimerLive.Helpers.AttributeHelpers.classnames([nil, ["class1", "class2"], "class3"])
      "class1 class2 class3"
  """
  def classnames(input_classnames) do
    concat(input_classnames_normalize(input_classnames), " ")
  end

  def inline_styles(input_styles) do
    concat(input_styles, "; ")
  end

  defp concat(list, joiner) do
    result =
      list
      |> Enum.reject(&(is_nil(&1) || &1 == false || &1 == ""))
      |> Enum.map(&String.trim(&1))
      |> Enum.uniq()
      |> Enum.join(joiner)

    if result == "" do
      nil
    else
      result
    end
  end

  # Make it works with HEEx and Surface
  # - [nil, "class1", "class2"] (HEEx | ~H\""" \""")
  # - [nil, ["class1", "class2"], "class3"] (.sface | ~F\""" \"""")
  defp input_classnames_normalize(input_classnames) do
    input_classnames
    |> Enum.map(&input_classnames_list_to_string/1)
  end

  defp input_classnames_list_to_string(class) when is_list(class), do: Enum.join(class, " ")
  defp input_classnames_list_to_string(class), do: class

  @doc ~S"""
  Concatenates 2 keyword lists of attributes.
  - Ignores any nil or false entries
  - Removes duplicate entries

  ## Tests

      iex> PrimerLive.Helpers.AttributeHelpers.append_attributes([], [[]])
      []

      iex> PrimerLive.Helpers.AttributeHelpers.append_attributes([[]])
      []

      iex> PrimerLive.Helpers.AttributeHelpers.append_attributes([dir: "rtl"], [[]])
      [dir: "rtl"]

      iex> PrimerLive.Helpers.AttributeHelpers.append_attributes([dir: "rtl"], [[placeholder: "hello"]])
      [dir: "rtl", placeholder: "hello"]

      iex> PrimerLive.Helpers.AttributeHelpers.append_attributes([dir: "rtl"], %{"placeholder" => "hello"})
      [dir: "rtl", placeholder: "hello"]

      iex> PrimerLive.Helpers.AttributeHelpers.append_attributes([dir: "rtl"], [false, [placeholder: "hello"], [placeholder: "hello"], nil])
      [dir: "rtl", placeholder: "hello"]

      iex> is_foo = true
      iex> is_bar = false
      iex> extra = [class: "x"]
      iex> PrimerLive.Helpers.AttributeHelpers.append_attributes(extra, [
      ...>   is_foo and [foo: "foo"],
      ...>   is_bar and [bar: "bar"]
      ...> ])
      [class: "x", foo: "foo"]

      iex> is_foo = true
      iex> is_bar = false
      iex> extra = %{class: "x"}
      iex> PrimerLive.Helpers.AttributeHelpers.append_attributes(extra, [
      ...>   is_foo and [foo: "foo"],
      ...>   is_bar and [bar: "bar"]
      ...> ])
      [class: "x", foo: "foo"]
  """
  def append_attributes(attributes, input_attributes) when is_map(attributes) do
    attr_list = convert_map_to_keyword_list(attributes)
    append_attributes(attr_list, input_attributes)
  end

  def append_attributes(attributes, input_attributes) when is_map(input_attributes) do
    input_attributes_list = convert_map_to_keyword_list(input_attributes)
    append_attributes(attributes, input_attributes_list)
  end

  def append_attributes(attributes, input_attributes) when is_nil(attributes),
    do: append_attributes([], input_attributes)

  def append_attributes(attributes, input_attributes) do
    flat_input_attributes =
      input_attributes
      |> Enum.reject(&(&1 == false || is_nil(&1)))
      |> List.flatten()

    flat_attributes = attributes |> List.flatten()

    flat_attributes
    |> Keyword.merge(flat_input_attributes)
    |> Enum.uniq()
    |> Enum.sort()
  end

  def append_attributes(input_attributes), do: append_attributes([], input_attributes)

  @doc ~S"""
  Passes arguments to Phoenix.LiveView.Helpers.assigns_to_attributes and sorts the result.
  """
  def assigns_to_attributes_sorted(assigns, exclude \\ []) do
    assigns_to_attributes(assigns, exclude) |> Enum.sort()
  end

  defp convert_map_to_keyword_list(map) when map == %{}, do: nil

  defp convert_map_to_keyword_list(map) do
    Keyword.new(map, fn {k, v} ->
      {to_atom(k), v}
    end)
  end

  defp to_atom(key) when is_atom(key), do: key
  defp to_atom(key) when is_binary(key), do: String.to_existing_atom(key)
  defp to_atom(key), do: key

  @doc ~S"""
  Converts user input to an integer, with optionally a default value

  ## Tests

      iex> PrimerLive.Helpers.AttributeHelpers.as_integer(nil)
      nil

      iex> PrimerLive.Helpers.AttributeHelpers.as_integer("1")
      1

      iex> PrimerLive.Helpers.AttributeHelpers.as_integer(2)
      2

      iex> PrimerLive.Helpers.AttributeHelpers.as_integer(2.0)
      2

      iex> PrimerLive.Helpers.AttributeHelpers.as_integer("x")
      nil

      iex> PrimerLive.Helpers.AttributeHelpers.as_integer("x", 42)
      42
  """
  def as_integer(input, default_value \\ nil)
  def as_integer(input, _default_value) when is_integer(input), do: input
  def as_integer(input, _default_value) when is_float(input), do: trunc(input)

  def as_integer(input, default_value) when is_binary(input) do
    String.to_integer(input)
  rescue
    ArgumentError -> default_value
  end

  def as_integer(_input, default_value), do: default_value

  @doc ~S"""
  Converts user input to a boolean, with optionally a default value

  ## Tests

      iex> PrimerLive.Helpers.AttributeHelpers.as_boolean(true)
      true

      iex> PrimerLive.Helpers.AttributeHelpers.as_boolean("true")
      true

      iex> PrimerLive.Helpers.AttributeHelpers.as_boolean("1")
      true

      iex> PrimerLive.Helpers.AttributeHelpers.as_boolean(1)
      true

      iex> PrimerLive.Helpers.AttributeHelpers.as_boolean(1.0)
      true

      iex> PrimerLive.Helpers.AttributeHelpers.as_boolean(false)
      false

      iex> PrimerLive.Helpers.AttributeHelpers.as_boolean("false")
      false

      iex> PrimerLive.Helpers.AttributeHelpers.as_boolean("0")
      false

      iex> PrimerLive.Helpers.AttributeHelpers.as_boolean(0)
      false

      iex> PrimerLive.Helpers.AttributeHelpers.as_boolean(0.0)
      false

      iex> PrimerLive.Helpers.AttributeHelpers.as_boolean("x")
      false

      iex> PrimerLive.Helpers.AttributeHelpers.as_boolean("100")
      true

      iex> PrimerLive.Helpers.AttributeHelpers.as_boolean("100.0")
      true

      iex> PrimerLive.Helpers.AttributeHelpers.as_boolean("0.1")
      false

      iex> PrimerLive.Helpers.AttributeHelpers.as_boolean(%{})
      false

  """
  def as_boolean(input, default_value \\ false)
  def as_boolean(input, _default_value) when is_boolean(input), do: input

  def as_boolean(input, _default_value) when is_binary(input) and input === "true", do: true
  def as_boolean(input, _default_value) when is_binary(input) and input === "1", do: true
  def as_boolean(input, _default_value) when is_binary(input) and input === "false", do: false
  def as_boolean(input, _default_value) when is_binary(input) and input === "0", do: false

  def as_boolean(input, default_value) when is_binary(input) do
    case Integer.parse(input) do
      {int, _rest} -> as_boolean(int, default_value)
      _ -> default_value
    end
  end

  def as_boolean(input, _default_value) when is_number(input) do
    if input > 0 do
      true
    else
      false
    end
  end

  def as_boolean(_input, default_value), do: default_value

  @doc """
  Takes 2 lists and padds the shortest list with placeholder values.

  ## Tests

      iex> PrimerLive.Helpers.AttributeHelpers.pad_lists([], [])
      [[], []]

      iex> PrimerLive.Helpers.AttributeHelpers.pad_lists([1, 2, 3], [])
      [[1, 2, 3], [:placeholder, :placeholder, :placeholder]]

      iex> PrimerLive.Helpers.AttributeHelpers.pad_lists([], [1, 2, 3])
      [[:placeholder, :placeholder, :placeholder], [1, 2, 3]]

      iex> PrimerLive.Helpers.AttributeHelpers.pad_lists([1], [1, 2])
      [[1, :placeholder], [1, 2]]

      iex> PrimerLive.Helpers.AttributeHelpers.pad_lists([], [1, 2, 3], 0)
      [[0, 0, 0], [1, 2, 3]]

      iex> header_slot = []
      iex> header_title_slot = [%{
      ...>   __slot__: :header_title,
      ...>   inner_block: "Title content"
      ...> }]
      iex> Enum.zip(PrimerLive.Helpers.AttributeHelpers.pad_lists(header_slot, header_title_slot, []))
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

  @doc """
  Forces a value to be within a min and max value.any()

  ## Tests

      iex> PrimerLive.Helpers.AttributeHelpers.minmax(-1, 0, 2)
      0

      iex> PrimerLive.Helpers.AttributeHelpers.minmax(3, 0, 2)
      2

      iex> PrimerLive.Helpers.AttributeHelpers.minmax(0, 0, 0)
      0

      iex> PrimerLive.Helpers.AttributeHelpers.minmax(1, 0, 0)
      0

  """
  def minmax(value, min, max) do
    max(min, min(value, max))
  end

  @doc """
  From: https://gist.github.com/ahmadshah/8d978bbc550128cca12dd917a09ddfb7?permalink_comment_id=4178225#gistcomment-4178225

  A helper functions to generate a random (printable) string of given `len`.
  You could change the hard-coded ascii codes 32 and 126 to only
  uppercase letters, digits, etc...
  """
  def random_string(len \\ 12) when is_integer(len) and len > 0 do
    for(_ <- 1..len, do: rand_uniform(98, 122))
    |> List.to_string()
  end

  # Returns a random integer uniformly distributed in the range
  # `n <= X <= m`.
  #
  # If the random variable `X` is uniformly distributed in the range
  # `1 <= X <= m - n + 1`, then r.v `Y = X + n - 1` is uniformly
  # distributed in the range `n <= Y <= m`.
  # (Because we just shift X to the right).
  defp rand_uniform(n, m) do
    # random X
    :rand.uniform(m - n + 1)
    # shift X to the right to get Y
    |> Kernel.+(n - 1)
  end

  @doc """
  Verifies if a slot should be handled as a link.

  ## Tests

      iex> PrimerLive.Helpers.AttributeHelpers.link?(%{href: "#url"})
      true

      iex> PrimerLive.Helpers.AttributeHelpers.link?(%{navigate: "#url"})
      true

      iex> PrimerLive.Helpers.AttributeHelpers.link?(%{patch: "#url"})
      true

      iex> PrimerLive.Helpers.AttributeHelpers.link?(%{url: "#url"})
      false
  """
  def link?(assigns), do: !!link_url(assigns)

  defp link_url(assigns), do: assigns[:href] || assigns[:navigate] || assigns[:patch]

  @doc """
  Verifies if a slot should be handled as a link.

  ## Tests

      iex> PrimerLive.Helpers.AttributeHelpers.anchor_link?(%{})
      false

      iex> PrimerLive.Helpers.AttributeHelpers.anchor_link?(%{href: "/url"})
      false

      iex> PrimerLive.Helpers.AttributeHelpers.anchor_link?(%{href: "url"})
      false

      iex> PrimerLive.Helpers.AttributeHelpers.anchor_link?(%{href: "#url"})
      true
  """
  def anchor_link?(assigns) do
    link_url(assigns) |> anchor_link_url?()
  end

  defp anchor_link_url?(url) when is_nil(url), do: false

  defp anchor_link_url?(url) do
    String.match?(url, ~r/^#/)
  end

  @doc """
  Creates a DOM-safe ID string from a label and optional prefix.

          iex> PrimerLive.Helpers.AttributeHelpers.create_dom_id(nil)
          nil
          
          iex> PrimerLive.Helpers.AttributeHelpers.create_dom_id("")
          nil

          iex> PrimerLive.Helpers.AttributeHelpers.create_dom_id("hello")
          "hello"

          iex> PrimerLive.Helpers.AttributeHelpers.create_dom_id("hello", "pre")
          "pre-hello"

          iex> PrimerLive.Helpers.AttributeHelpers.create_dom_id("dark_high_contrast")
          "dark-high-contrast"

          iex> PrimerLive.Helpers.AttributeHelpers.create_dom_id("hello 123 bye (465) #$!", "pre")
          "pre-hello-123-bye-465"

          iex> PrimerLive.Helpers.AttributeHelpers.create_dom_id("hello 123 bye (465) #$!", "form-01910f69-5f44-7603-bef1-475485871486")
          "form-01910f69-5f44-7603-bef1-475485871486-hello-123-bye-465"

          iex> PrimerLive.Helpers.AttributeHelpers.create_dom_id("hello 123 bye (465) #$!", "999-form-01910f69-5f44-7603-bef1-475485871486")
          "form-01910f69-5f44-7603-bef1-475485871486-hello-123-bye-465"
  """
  def create_dom_id(label, prefix \\ "") do
    prefix = String.replace(prefix, ~r/^[0-9]+/, "-")

    dom_id =
      [prefix, label]
      |> Enum.join("-")
      |> String.replace(~r/[^A-Za-z0-9]/, "-")
      |> String.replace(~r/[-]+/, "-")
      |> String.trim("-")
      |> String.downcase()

    if dom_id == "", do: nil, else: dom_id
  end

  @doc """
  Generates the input name of a form field, using `Phoenix.HTML.Form.input_name/2` with support for multiple inputs (e.g. checkboxes).
  Param opts accepts
  - name: the field name
  - is_multiple

  ## Tests

      iex> PrimerLive.Helpers.AttributeHelpers.input_name(nil, nil)
      nil

      iex> PrimerLive.Helpers.AttributeHelpers.input_name("my-form", nil)
      "my-form"

      iex> PrimerLive.Helpers.AttributeHelpers.input_name("my-form", "field")
      "my-form[field]"

      iex> PrimerLive.Helpers.AttributeHelpers.input_name(:form, nil)
      "form"

      iex> PrimerLive.Helpers.AttributeHelpers.input_name(nil, "my-field")
      "[my-field]"

      iex> PrimerLive.Helpers.AttributeHelpers.input_name(nil, :first_name)
      "[first_name]"

      iex> PrimerLive.Helpers.AttributeHelpers.input_name(:profile, :first_name)
      "profile[first_name]"

      iex> PrimerLive.Helpers.AttributeHelpers.input_name(nil, nil, name: "my-first-name")
      "my-first-name"

      iex> PrimerLive.Helpers.AttributeHelpers.input_name(:profile, nil, name: "my-first-name")
      "profile[my-first-name]"

      iex> PrimerLive.Helpers.AttributeHelpers.input_name(:profile, :first_name, name: "my-first-name")
      "profile[my-first-name]"

      iex> PrimerLive.Helpers.AttributeHelpers.input_name(:profile, :first_name, is_multiple: true)
      "profile[first_name][]"

      iex> PrimerLive.Helpers.AttributeHelpers.input_name(%Phoenix.HTML.Form{
      ...>   name: :profile,
      ...>   source: %Ecto.Changeset{
      ...>     action: :update,
      ...>     changes: %{first_name: "annette"},
      ...>     errors: [],
      ...>     data: nil,
      ...>     valid?: true
      ...>   }
      ...> }, :first_name)
      "profile[first_name]"

      iex> PrimerLive.Helpers.AttributeHelpers.input_name(%PrimerLive.Helpers.TestForm{
      ...>   source: %PrimerLive.Helpers.TestForm{
      ...>     name: "test",
      ...>     source: %Phoenix.HTML.Form{
      ...>       name: :profile,
      ...>     }
      ...>   }
      ...> }, :first_name)
      "first_name"
  """

  def input_name(form_or_name, field, opts \\ [])

  def input_name(form, field, opts) do
    _input_name(form, field, opts[:name], !!opts[:is_multiple])
  end

  defp _input_name(form, field, name, _is_multiple) when is_nil(form) and is_nil(field),
    do: name

  defp _input_name(form, field, name, is_multiple) do
    single_input_name =
      Phoenix.HTML.Form.input_name(form, name || field || "")
      |> String.replace(~r/(\[\])+$/, "")

    cond do
      is_multiple && single_input_name !== "" -> single_input_name <> "[]"
      single_input_name !== "" -> single_input_name
      true -> nil
    end
  end

  @doc """
  Generates the input id of a form field.

  ## Tests

      iex> PrimerLive.Helpers.AttributeHelpers.input_id("my-input-id", nil, nil, "", nil, false)
      "my-input-id"

      iex> PrimerLive.Helpers.AttributeHelpers.input_id("my-input-id", nil, nil, "", nil, true)
      "my-input-id"

      iex> PrimerLive.Helpers.AttributeHelpers.input_id("my-input-id", nil, nil, "", "my-value", true)
      "my-input-id-my-value"

      iex> PrimerLive.Helpers.AttributeHelpers.input_id(nil, "my-id", nil, "", nil, false)
      "my-id"

      iex> PrimerLive.Helpers.AttributeHelpers.input_id(nil, nil, :select, "", nil, false)
      nil

      iex> PrimerLive.Helpers.AttributeHelpers.input_id(nil, nil, :select, "[my-input-name]", nil, false)
      "[my-input-name]"

      iex> PrimerLive.Helpers.AttributeHelpers.input_id(nil, nil, :select, "[my-input-name][]", nil, false)
      "[my-input-name]"

      iex> PrimerLive.Helpers.AttributeHelpers.input_id(nil, nil, :checkbox, "", nil, false)
      nil

      iex> PrimerLive.Helpers.AttributeHelpers.input_id(nil, nil, :checkbox, "my-input-name", nil, false)
      "my-input-name"

      iex> PrimerLive.Helpers.AttributeHelpers.input_id(nil, nil, :checkbox, "my-input-name", "my-value", false)
      "my-input-name[my-value]"

      iex> PrimerLive.Helpers.AttributeHelpers.input_id(nil, nil, :checkbox, "[my-input-name]", "my-value", false)
      "[my-input-name][my-value]"

      iex> PrimerLive.Helpers.AttributeHelpers.input_id(nil, nil, :checkbox, "[my-input-name][]", "my-value", false)
      "[my-input-name][my-value]"

      iex> PrimerLive.Helpers.AttributeHelpers.input_id(nil, nil, :checkbox, "[my-input-name][]", nil, false)
      "[my-input-name][]"

      iex> PrimerLive.Helpers.AttributeHelpers.input_id(nil, nil, :radio_button, "", nil, false)
      nil

      iex> PrimerLive.Helpers.AttributeHelpers.input_id(nil, nil, :radio_button, "my-input-name", nil, false)
      "my-input-name"

      iex> PrimerLive.Helpers.AttributeHelpers.input_id(nil, nil, :radio_button, "my-input-name", "my-value", false)
      "my-input-name[my-value]"

  """
  def input_id(input_id, _id, _input_type, _input_name, value_for_derived_label, is_multiple)
      when not is_nil(input_id) and is_multiple and is_binary(value_for_derived_label),
      do: "#{input_id}-#{value_for_derived_label}"

  def input_id(input_id, _id, _input_type, _input_name, _value_for_derived_label, _is_multiple)
      when not is_nil(input_id),
      do: input_id

  def input_id(_input_id, id, _input_type, _input_name, _value_for_derived_label, _is_multiple)
      when not is_nil(id),
      do: id

  def input_id(_input_id, _id, input_type, "", _value_for_derived_label, _is_multiple)
      when input_type === :select,
      do: nil

  def input_id(_input_id, _id, input_type, input_name, _value_for_derived_label, _is_multiple)
      when input_type === :select,
      do: input_name |> String.replace(~r/\[\]$/, "")

  def input_id(_input_id, _id, input_type, "", value_for_derived_label, _is_multiple)
      when input_type === :checkbox or input_type === :radio_button,
      do: value_for_derived_label

  def input_id(_input_id, _id, input_type, input_name, value_for_derived_label, _is_multiple)
      when (input_type === :checkbox or input_type === :radio_button) and is_binary(input_name) do
    cond do
      String.match?(input_name, ~r/\[\]$/) ->
        String.replace(input_name, ~r/(\[\]$)/, "[#{value_for_derived_label}]")

      !is_nil(value_for_derived_label) ->
        "#{input_name}[#{value_for_derived_label}]"

      true ->
        input_name
    end
  end

  def input_id(_input_id, _id, _input_type, "", _value_for_derived_label, _is_multiple), do: nil

  def input_id(_input_id, _id, _input_type, input_name, _value_for_derived_label, _is_multiple),
    do: input_name

  @spec cleanup_id(nil | binary) :: nil | binary
  def cleanup_id(id) when is_nil(id), do: nil

  def cleanup_id(id) do
    id
    |> String.replace(~r/(\]\[)|(\[\])|\[|\]/, "_")
    |> String.replace(~r/^(\_)*/, "")
    |> String.replace(~r/(\_)*$/, "")
  end

  @doc ~S"""
  Extracts common attributes for form inputs. Shared for consistency.
  """
  def common_input_attrs(assigns, input_type \\ nil) do
    common_shared_attrs = common_shared_attrs(assigns)

    # ID and label
    id_attrs = common_id_attrs(assigns, input_type, common_shared_attrs)

    # Field state
    field_state_attrs =
      common_field_state_attrs(
        assigns,
        id_attrs,
        common_shared_attrs
      )

    # Form control
    form_control_attrs =
      common_form_control_attrs(assigns, id_attrs.input_id, common_shared_attrs)
      |> Map.merge(field_state_attrs |> Map.drop([:caption]))

    [
      common_shared_attrs,
      id_attrs,
      form_control_attrs,
      field_state_attrs
    ]
    |> Enum.reduce(&Map.merge/2)
  end

  defp common_shared_attrs(assigns) do
    rest = assigns[:rest]
    name = assigns[:name] || rest[:name]
    form = assigns[:form]
    field = assigns[:field]
    field_or_name = field || name || ""

    %{
      rest: rest,
      name: name,
      form: form,
      field: field,
      field_or_name: field_or_name
    }
  end

  defp common_id_attrs(
         assigns,
         input_type,
         %{form: form, field: field, rest: rest, name: name}
       ) do
    id = cleanup_id(assigns[:id] || rest[:id])

    is_multiple = !!assigns[:is_multiple]
    checked_value = assigns[:checked_value]

    input_name =
      if !is_nil(form) || !is_nil(field),
        do: input_name(form, field, name: name, is_multiple: is_multiple),
        else: name

    phx_feedback_for_id = input_name

    value = assigns[:value] || rest[:value]
    value_for_derived_label = checked_value || value

    input_id =
      assigns.input_id ||
        input_id(
          assigns[:input_id],
          id,
          input_type,
          input_name,
          value_for_derived_label,
          is_multiple
        )
        |> create_dom_id()

    derived_label =
      case input_type do
        :checkbox -> Phoenix.Naming.humanize(value_for_derived_label || field)
        :radio_button -> Phoenix.Naming.humanize(value_for_derived_label)
        _ -> nil
      end

    %{
      derived_label: derived_label,
      input_id: input_id,
      id: id,
      input_name: input_name,
      phx_feedback_for_id: phx_feedback_for_id,
      value: value
    }
  end

  defp common_form_control_attrs(assigns, input_id, %{
         form: form,
         field_or_name: field_or_name
       }) do
    form_control = assigns[:form_control]
    is_form_control = assigns[:is_form_control] || !!form_control

    has_form_control = is_form_control

    form_control_attrs =
      Map.merge(form_control || %{}, %{
        form: form,
        field: field_or_name,
        input_id: input_id,
        for: input_id,
        is_full_width: assigns[:is_full_width]
      })

    %{
      form_control_attrs: form_control_attrs,
      has_form_control: has_form_control
    }
  end

  defp common_field_state_attrs(assigns, %{input_name: input_name, input_id: input_id, id: id}, %{
         form: form,
         field_or_name: field_or_name
       }) do
    validation_message = assigns[:validation_message]
    caption = assigns[:caption]
    field_state = FormHelpers.field_state(form, field_or_name, validation_message, caption)

    %{
      message: message,
      valid?: valid?,
      required?: required?,
      ignore_errors?: ignore_errors?,
      caption: caption
    } = field_state

    has_changeset? = !is_nil(field_state.changeset)
    show_message? = !!message && !ignore_errors? && assigns[:type] !== "hidden"

    validation_message_id =
      cond do
        !show_message? -> nil
        assigns[:validation_message_id] -> assigns[:validation_message_id]
        input_id -> "#{input_id}-validation"
        id -> "#{id}-validation"
        true -> random_string()
      end

    validation_marker_class =
      if has_changeset? do
        cond do
          valid? == false -> "pl-invalid"
          valid? && show_message? -> "pl-valid"
          valid? && !show_message? -> "pl-neutral"
        end
      end

    ## Phoenix uses phx_feedback_for to hide form field errors that are untouched.
    ## However, this attribute can't be set on the element itself (the JS DOM library stalls).
    ## Element "validation_marker" is used as stopgap: a separate element placed just before the input element.
    validation_marker_attrs =
      case has_changeset? && show_message? do
        true ->
          [
            "phx-feedback-for": input_name
          ]

        false ->
          nil
      end

    %{
      message: message,
      valid?: valid?,
      required?: required?,
      ignore_errors?: ignore_errors?,
      show_message?: show_message?,
      validation_message_id: validation_message_id,
      validation_marker_attrs: validation_marker_attrs,
      validation_marker_class: validation_marker_class,
      caption: caption
    }
  end

  @doc ~S"""
  Extracts menu/dialog prompt attributes.
  """
  def prompt_attrs(assigns, %{
        component: component,
        toggle_slot: toggle_slot,
        toggle_class: toggle_class,
        menu_class: menu_class,
        is_menu: is_menu
      }) do
    id = assigns[:id] || assigns.rest[:id] || random_string()

    if is_nil(id), do: ComponentHelpers.missing_attribute(component, "'id'")

    focus_wrap_id = "focus-wrap-#{id}"

    focus_wrap_attrs =
      append_attributes([
        [
          "data-focuswrap": "",
          id: focus_wrap_id,
          "phx-key": "Escape",
          "phx-window-keydown": assigns.is_escapable && PromptHelpers.cancel_prompt(id)
        ]
      ])

    toggle_id =
      if id,
        do: "#{id}-toggle",
        else: id

    toggle_rest = assigns_to_attributes_sorted(toggle_slot || [], [:class, :for, :options])

    toggle_attrs =
      append_attributes(toggle_rest, [
        [
          "aria-haspopup": "true",
          "aria-owns": focus_wrap_id,
          class: toggle_class,
          "phx-click": Keyword.get(toggle_rest, :"phx-click", PromptHelpers.toggle_prompt(id)),
          type: "button"
        ]
      ])

    id_selector = "##{id}"
    prompt_id = id || "menu-" <> toggle_id
    show_state = assigns.show_state || "default"
    is_show_on_mount = !!assigns.is_show_on_mount
    is_show = assigns.is_show || is_show_on_mount

    is_opening_transitions_disabled = show_state == "hold" || is_show_on_mount
    is_focus_first_disabled = show_state == "hold"
    is_push_drawer = !!assigns[:is_push]

    prompt_attrs =
      append_attributes(assigns.rest |> Map.drop([:id]), [
        [
          class:
            classnames([
              menu_class,
              is_show_on_mount && "is-open is-showing is-show_on_mount",
              is_push_drawer && "is-show_on_mount"
            ])
        ],
        ["data-prompt": ""],
        [id: prompt_id],
        ["phx-hook": assigns.rest[:"phx-hook"] || "Prompt"],
        is_show && ["phx-mounted": JS.exec("data-open", to: id_selector)],
        show_state == "default" &&
          [
            "phx-remove": assigns.on_cancel && PromptHelpers.close_prompt(id)
          ],
        ["data-cancel": JS.exec(assigns.on_cancel || %JS{}, "data-close")],
        [
          "data-open":
            %JS{}
            |> maybe_focus_after_closing_selector(assigns.focus_after_closing_selector)
            |> maybe_set_transition_duration_style(
              if(is_opening_transitions_disabled, do: nil, else: assigns.transition_duration),
              id_selector,
              is_menu
            )
            |> maybe_send_status_event(
              assigns.transition_duration,
              if(is_opening_transitions_disabled, do: nil, else: assigns.status_callback_selector),
              id_selector,
              is_menu,
              "prompt:open"
            )
            |> JS.add_class("is-open", to: id_selector)
            |> maybe_focus_first(id_selector, is_focus_first_disabled)
            |> maybe_focus_after_opening_selector(assigns.focus_after_opening_selector)
            |> maybe_add_delay_to_show(id_selector, is_opening_transitions_disabled)
            |> maybe_remove_classes(id_selector, %{
              is_show_on_mount: is_show_on_mount,
              is_push_drawer: is_push_drawer
            })
        ],
        [
          "data-close":
            %JS{}
            |> maybe_send_status_event(
              assigns.transition_duration,
              assigns.status_callback_selector,
              id_selector,
              is_menu,
              "prompt:close"
            )
            |> maybe_set_transition_duration_style(
              assigns.transition_duration,
              id_selector,
              is_menu
            )
            |> JS.remove_class("is-showing", to: id_selector)
            |> JS.remove_class("is-open",
              transition: {"duration-#{assigns.transition_duration}", "", ""},
              time: assigns.transition_duration,
              to: id_selector
            )
            |> JS.pop_focus()
        ],
        is_menu && ["data-ismenu": ""],
        assigns[:is_fast] && ["data-isfast": ""],
        assigns.is_escapable != false && ["data-isescapable": ""]
      ])

    is_backdrop = !!assigns[:is_backdrop]

    backdrop_strength =
      cond do
        is_backdrop && assigns[:backdrop_strength] -> assigns[:backdrop_strength]
        is_backdrop && is_menu -> "light"
        true -> nil
      end

    backdrop_tint =
      if is_backdrop && assigns[:backdrop_tint] do
        assigns[:backdrop_tint]
      else
        nil
      end

    backdrop_attrs =
      append_attributes([
        is_backdrop && ["data-backdrop": ""],
        backdrop_strength && ["data-backdrop-strength": backdrop_strength],
        backdrop_tint && ["data-backdrop-tint": backdrop_tint]
      ])

    is_modal = assigns[:is_modal] || false

    touch_layer_attrs =
      append_attributes([
        [
          "data-touch": "",
          "phx-click": not is_modal && PromptHelpers.cancel_prompt(id)
        ]
      ])

    %{
      toggle_attrs: toggle_attrs,
      prompt_attrs: prompt_attrs,
      backdrop_attrs: backdrop_attrs,
      touch_layer_attrs: touch_layer_attrs,
      focus_wrap_attrs: focus_wrap_attrs
    }
  end

  defp maybe_focus_first(js, _id_selector, is_focus_first_disabled)
       when is_focus_first_disabled,
       do: js

  defp maybe_focus_first(js, id_selector, _is_focus_first_disabled) do
    JS.focus_first(js, to: "#{id_selector} [data-content]")
  end

  defp maybe_focus_after_opening_selector(js, selector) when is_nil(selector), do: js

  defp maybe_focus_after_opening_selector(js, selector) do
    JS.focus(js, to: selector)
  end

  defp maybe_focus_after_closing_selector(js, selector) when is_nil(selector),
    do: js

  defp maybe_focus_after_closing_selector(js, selector) do
    JS.push_focus(js, to: selector)
  end

  defp maybe_send_status_event(
         js,
         _transition_duration,
         status_callback_selector,
         _id_selector,
         _is_menu,
         _event_name
       )
       when is_nil(status_callback_selector),
       do: js

  defp maybe_send_status_event(
         js,
         transition_duration,
         status_callback_selector,
         id_selector,
         is_menu,
         event_name
       )
       when is_menu do
    dispatch_send_status_event(
      js,
      transition_duration || PromptHelpers.default_menu_transition_duration(),
      status_callback_selector,
      id_selector,
      event_name
    )
  end

  defp maybe_send_status_event(
         js,
         transition_duration,
         status_callback_selector,
         id_selector,
         _is_menu,
         event_name
       ) do
    dispatch_send_status_event(
      js,
      transition_duration || PromptHelpers.default_dialog_transition_duration(),
      status_callback_selector,
      id_selector,
      event_name
    )
  end

  defp maybe_add_delay_to_show(js, id_selector, is_opening_transitions_disabled)
       when is_opening_transitions_disabled do
    JS.add_class(js, "is-showing", to: id_selector)
  end

  defp maybe_add_delay_to_show(js, id_selector, _is_opening_transitions_disabled) do
    transition_delay = 30

    JS.add_class(js, "is-showing",
      # Small delay to create a fade-in effect
      transition: {"duration-#{transition_delay}", "", ""},
      time: transition_delay,
      to: id_selector
    )
  end

  defp maybe_remove_classes(js, id_selector, %{
         is_show_on_mount: is_show_on_mount,
         is_push_drawer: is_push_drawer
       })
       when is_show_on_mount or is_push_drawer do
    JS.remove_class(js, "is-show_on_mount", to: id_selector)
  end

  defp maybe_remove_classes(js, _id_selector, _is_show_on_mount), do: js

  defp dispatch_send_status_event(
         js,
         transition_duration,
         status_callback_selector,
         id_selector,
         event_name
       ) do
    JS.dispatch(js, event_name,
      to: id_selector,
      detail: %{selector: status_callback_selector, transitionDuration: transition_duration}
    )
  end

  defp maybe_set_transition_duration_style(js, transition_duration, _id_selector, _is_menu)
       when is_nil(transition_duration),
       do: js

  defp maybe_set_transition_duration_style(js, transition_duration, id_selector, is_menu)
       when is_menu do
    maybe_create_transition_duration_style_attribute(
      js,
      transition_duration,
      id_selector,
      transition_duration == PromptHelpers.default_menu_transition_duration()
    )
  end

  defp maybe_set_transition_duration_style(js, transition_duration, id_selector, _is_menu) do
    maybe_create_transition_duration_style_attribute(
      js,
      transition_duration,
      id_selector,
      transition_duration == PromptHelpers.default_dialog_transition_duration()
    )
  end

  defp maybe_create_transition_duration_style_attribute(
         js,
         _transition_duration,
         _id_selector,
         is_default_transition_duration
       )
       when is_default_transition_duration do
    js
  end

  defp maybe_create_transition_duration_style_attribute(
         js,
         transition_duration,
         id_selector,
         _is_default_transition_duration
       ) do
    JS.set_attribute(
      js,
      {"style",
       "--prompt-transition-duration: #{transition_duration}ms; --prompt-fast-transition-duration: #{transition_duration}ms;"},
      to: id_selector
    )
  end
end
