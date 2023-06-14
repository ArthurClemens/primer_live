defmodule PrimerLive.Helpers.AttributeHelpers do
  @moduledoc false

  use Phoenix.Component
  alias PrimerLive.Helpers.FormHelpers

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
  """
  def classnames(input_classnames) do
    concat(input_classnames, " ")
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
    attr_list = Keyword.new(attributes)
    append_attributes(attr_list, input_attributes)
  end

  def append_attributes(attributes, input_attributes) when is_nil(attributes),
    do: append_attributes([], input_attributes)

  def append_attributes(attributes, input_attributes) do
    input_attributes
    |> Enum.reject(&(&1 == false || is_nil(&1)))
    |> Enum.uniq()
    |> Enum.reduce(attributes, fn kw, acc ->
      acc ++ kw
    end)
  end

  def append_attributes(input_attributes), do: append_attributes([], input_attributes)

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
    try do
      String.to_integer(input)
    rescue
      ArgumentError -> default_value
    end
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
  Generates a random string.
  """
  def random_string(), do: Ecto.UUID.generate()

  @doc """
  Verifies if a slot should be handled as a link.

  ## Tests

      iex> PrimerLive.Helpers.AttributeHelpers.is_link?(%{href: "#url"})
      true

      iex> PrimerLive.Helpers.AttributeHelpers.is_link?(%{navigate: "#url"})
      true

      iex> PrimerLive.Helpers.AttributeHelpers.is_link?(%{patch: "#url"})
      true

      iex> PrimerLive.Helpers.AttributeHelpers.is_link?(%{url: "#url"})
      false
  """
  def is_link?(assigns), do: !!link_url(assigns)

  defp link_url(assigns), do: assigns[:href] || assigns[:navigate] || assigns[:patch]

  @doc """
  Verifies if a slot should be handled as a link.

  ## Tests

      iex> PrimerLive.Helpers.AttributeHelpers.is_anchor_link?(%{})
      false

      iex> PrimerLive.Helpers.AttributeHelpers.is_anchor_link?(%{href: "/url"})
      false

      iex> PrimerLive.Helpers.AttributeHelpers.is_anchor_link?(%{href: "url"})
      false

      iex> PrimerLive.Helpers.AttributeHelpers.is_anchor_link?(%{href: "#url"})
      true
  """
  def is_anchor_link?(assigns) do
    link_url(assigns) |> is_anchor_link_url?()
  end

  defp is_anchor_link_url?(url) when is_nil(url), do: false

  defp is_anchor_link_url?(url) do
    String.match?(url, ~r/^#/)
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
  """

  def input_name(form, field, opts \\ []) do
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

      iex> PrimerLive.Helpers.AttributeHelpers.input_id("my-input-id", nil, nil, "", nil)
      "my-input-id"

      iex> PrimerLive.Helpers.AttributeHelpers.input_id(nil, "my-id", nil, "", nil)
      "my-id"

      iex> PrimerLive.Helpers.AttributeHelpers.input_id(nil, nil, :select, "", nil)
      nil

      iex> PrimerLive.Helpers.AttributeHelpers.input_id(nil, nil, :select, "[my-input-name]", nil)
      "[my-input-name]"

      iex> PrimerLive.Helpers.AttributeHelpers.input_id(nil, nil, :select, "[my-input-name][]", nil)
      "[my-input-name]"

      iex> PrimerLive.Helpers.AttributeHelpers.input_id(nil, nil, :checkbox, "", nil)
      nil

      iex> PrimerLive.Helpers.AttributeHelpers.input_id(nil, nil, :checkbox, "my-input-name", nil)
      "my-input-name"

      iex> PrimerLive.Helpers.AttributeHelpers.input_id(nil, nil, :checkbox, "my-input-name", "my-value")
      "my-input-name[my-value]"

      iex> PrimerLive.Helpers.AttributeHelpers.input_id(nil, nil, :checkbox, "[my-input-name]", "my-value")
      "[my-input-name][my-value]"

      iex> PrimerLive.Helpers.AttributeHelpers.input_id(nil, nil, :checkbox, "[my-input-name][]", "my-value")
      "[my-input-name][my-value]"

      iex> PrimerLive.Helpers.AttributeHelpers.input_id(nil, nil, :checkbox, "[my-input-name][]", nil)
      "[my-input-name][]"

      iex> PrimerLive.Helpers.AttributeHelpers.input_id(nil, nil, :radio_button, "", nil)
      nil

      iex> PrimerLive.Helpers.AttributeHelpers.input_id(nil, nil, :radio_button, "my-input-name", nil)
      "my-input-name"

      iex> PrimerLive.Helpers.AttributeHelpers.input_id(nil, nil, :radio_button, "my-input-name", "my-value")
      "my-input-name[my-value]"

  """
  def input_id(input_id, _id, _input_type, _input_name, _value_for_derived_label)
      when not is_nil(input_id),
      do: input_id

  def input_id(_input_id, id, _input_type, _input_name, _value_for_derived_label)
      when not is_nil(id),
      do: id

  def input_id(_input_id, _id, input_type, "", _value_for_derived_label)
      when input_type === :select,
      do: nil

  def input_id(_input_id, _id, input_type, input_name, _value_for_derived_label)
      when input_type === :select,
      do: input_name |> String.replace(~r/\[\]$/, "")

  def input_id(_input_id, _id, input_type, "", value_for_derived_label)
      when input_type === :checkbox or input_type === :radio_button,
      do: value_for_derived_label

  def input_id(_input_id, _id, input_type, input_name, value_for_derived_label)
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

  def input_id(_input_id, _id, _input_type, "", _value_for_derived_label), do: nil
  def input_id(_input_id, _id, _input_type, input_name, _value_for_derived_label), do: input_name

  @doc ~S"""
  Extracts common attributes for form inputs. Shared for consistency.
  """
  def common_input_attrs(assigns, input_type) do
    common_shared_attrs = common_shared_attrs(assigns)

    # ID and label
    id_attrs = common_id_attrs(assigns, input_type, common_shared_attrs)

    # Form group
    form_group_attrs = common_form_group_attrs(assigns, id_attrs.input_id, common_shared_attrs)

    # Field state
    field_state_attrs =
      common_field_state_attrs(
        assigns,
        id_attrs,
        common_shared_attrs
      )

    [
      common_shared_attrs,
      id_attrs,
      form_group_attrs,
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
    id = assigns[:id] || rest[:id]
    is_multiple = !!assigns[:is_multiple]
    checked_value = assigns[:checked_value]

    input_name =
      if !is_nil(form) || !is_nil(field),
        do: input_name(form, field, name: name, is_multiple: is_multiple),
        else: name

    phx_feedback_for_id = input_name

    value = assigns[:value] || rest[:value]
    value_for_derived_label = checked_value || value

    input_id = input_id(assigns[:input_id], id, input_type, input_name, value_for_derived_label)

    derived_label =
      case input_type do
        :checkbox -> Phoenix.HTML.Form.humanize(value_for_derived_label || field)
        :radio_button -> Phoenix.HTML.Form.humanize(value_for_derived_label)
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

  defp common_form_group_attrs(assigns, input_id, %{
         form: form,
         field_or_name: field_or_name
       }) do
    form_group = assigns[:form_group]
    is_form_group = assigns[:is_form_group]
    has_form_group = is_form_group || form_group

    form_group_attrs =
      Map.merge(form_group || %{}, %{
        form: form,
        field: field_or_name,
        for: input_id
      })

    %{
      form_group_attrs: form_group_attrs,
      has_form_group: has_form_group
    }
  end

  defp common_field_state_attrs(assigns, %{input_name: input_name, input_id: input_id}, %{
         form: form,
         field_or_name: field_or_name
       }) do
    validation_message = assigns[:validation_message]
    field_state = FormHelpers.field_state(form, field_or_name, validation_message)

    %{
      message: message,
      valid?: valid?,
      ignore_errors?: ignore_errors?
    } = field_state

    has_changeset = !is_nil(field_state.changeset)
    show_message? = !!message && !ignore_errors? && assigns[:type] !== "hidden"

    validation_message_id =
      if !is_nil(field_state.message),
        do:
          assigns[:validation_message_id] ||
            "#{input_id}-validation"

    validation_marker_class =
      case has_changeset && show_message? do
        true ->
          if valid? do
            "pl-valid"
          else
            "pl-invalid"
          end

        false ->
          nil
      end

    ## Phoenix uses phx_feedback_for to hide form field errors that are untouched.
    ## However, this attribute can't be set on the element itself (the JS DOM library stalls).
    ## Element "validation_marker" is used as stopgap: a separate element placed just before the input element.
    validation_marker_attrs =
      case has_changeset && show_message? do
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
      ignore_errors?: ignore_errors?,
      show_message?: show_message?,
      validation_message_id: validation_message_id,
      validation_marker_attrs: validation_marker_attrs,
      validation_marker_class: validation_marker_class
    }
  end

  @doc ~S"""
  Extracts menu/dialog prompt attributes.

  ## Tests

      Default values (with attr id to prevent getting random values in tests):
      iex> PrimerLive.Helpers.AttributeHelpers.prompt_attrs(
      ...>   %{
      ...>     rest: %{
      ...>       id: "some-id"
      ...>     },
      ...>     prompt_options: nil,
      ...>     is_fast: false,
      ...>     is_dark_backdrop: false,
      ...>     is_medium_backdrop: false,
      ...>     is_light_backdrop: false,
      ...>     is_backdrop: false
      ...>   },
      ...>   %{
      ...>     form: nil,
      ...>     field: nil,
      ...>     toggle_slot: nil,
      ...>     toggle_class: "btn",
      ...>     menu_class: "",
      ...>     is_menu: true,
      ...>   })
      %{
        backdrop_attrs: [],
        checkbox_attrs: [
          id: "some-id-toggle",
          "aria-hidden": "true",
          hidden_input: false,
          onchange: "window.Prompt && Prompt.change(this)"
        ],
        menu_attrs: [
          class: "",
          "data-prompt": "",
          id: "some-id",
          "phx-hook": "Prompt"
        ],
        toggle_attrs: [
          class: "btn",
          "aria-haspopup": "true",
          for: "some-id-toggle"
        ],
        touch_layer_attrs: ["data-touch": ""],
        focus_wrap_id: "focus-wrap-some-id",
      }

      Backdrop settings:
      iex> PrimerLive.Helpers.AttributeHelpers.prompt_attrs(
      ...>   %{
      ...>     rest: %{
      ...>       id: "some-id"
      ...>     },
      ...>     prompt_options: nil,
      ...>     is_fast: true,
      ...>     is_dark_backdrop: false,
      ...>     is_medium_backdrop: true,
      ...>     is_light_backdrop: false,
      ...>     is_backdrop: true
      ...>   },
      ...>   %{
      ...>     form: nil,
      ...>     field: nil,
      ...>     toggle_slot: nil,
      ...>     toggle_class: "btn",
      ...>     menu_class: "",
      ...>     is_menu: true
      ...>   })
      %{
        backdrop_attrs: [
          "data-backdrop": "",
          "data-ismedium": "",
        ],
        checkbox_attrs: [
          id: "some-id-toggle",
          "aria-hidden": "true",
          hidden_input: false,
          onchange: "window.Prompt && Prompt.change(this)"
        ],
        menu_attrs: [
          class: "",
          "data-prompt": "",
          id: "some-id",
          "phx-hook": "Prompt",
          "data-isfast": ""
        ],
        toggle_attrs: [
          class: "btn",
          "aria-haspopup": "true",
          for: "some-id-toggle"
        ],
        touch_layer_attrs: ["data-touch": ""],
        focus_wrap_id: "focus-wrap-some-id",
      }

      With form:
      iex> PrimerLive.Helpers.AttributeHelpers.prompt_attrs(
      ...>   %{
      ...>     rest: %{},
      ...>     prompt_options: nil,
      ...>     is_fast: true,
      ...>     is_dark_backdrop: true,
      ...>     is_medium_backdrop: false,
      ...>     is_light_backdrop: false,
      ...>     is_backdrop: true
      ...>   },
      ...>   %{
      ...>     form: %Phoenix.HTML.Form{
      ...>       source: %Ecto.Changeset{
      ...>         action: :update,
      ...>         changes: [],
      ...>         errors: [],
      ...>         data: nil,
      ...>         valid?: true
      ...>       },
      ...>     },
      ...>     field: :job,
      ...>     toggle_slot: nil,
      ...>     toggle_class: "btn",
      ...>     menu_class: "my-menu",
      ...>     is_menu: true
      ...>   })
      %{
        backdrop_attrs: [
          "data-backdrop": "",
          "data-isdark": "",
        ],
        checkbox_attrs: [
          id: "job",
          "aria-hidden": "true",
          hidden_input: true,
          onchange: "window.Prompt && Prompt.change(this)"
        ],
        menu_attrs: [
          class: "my-menu",
          "data-prompt": "",
          id: "menu-job",
          "phx-hook": "Prompt",
          "data-isfast": ""
        ],
        toggle_attrs: [
          class: "btn",
          "aria-haspopup": "true",
          for: "job"
        ],
        touch_layer_attrs: ["data-touch": ""],
        focus_wrap_id: "focus-wrap-job"
      }
  """
  def prompt_attrs(assigns, %{
        form: form,
        field: field,
        toggle_slot: toggle_slot,
        toggle_class: toggle_class,
        menu_class: menu_class,
        is_menu: is_menu
      }) do
    id = assigns[:id] || assigns.rest[:id]

    prompt_options = assigns[:prompt_options] || toggle_slot[:options]

    if !is_nil(toggle_slot[:options]) && Application.get_env(:primer_live, :env) !== :test do
      IO.puts(
        "Deprecated toggle options: pass prompt_options to the main component. Since 0.4.0."
      )
    end

    input_name = if field, do: Phoenix.HTML.Form.input_name(form, field), else: nil
    generated_id = id || input_name || random_string()

    toggle_id =
      if id,
        do: "#{id}-toggle",
        else: generated_id

    toggle_rest = assigns_to_attributes(toggle_slot || [], [:class, :for, :options])

    toggle_attrs =
      append_attributes(toggle_rest, [
        [
          class: toggle_class,
          "aria-haspopup": "true",
          for: toggle_id
        ]
      ])

    checkbox_attrs =
      append_attributes([
        [
          id: toggle_id,
          "aria-hidden": "true",
          # Only use the default extra hidden input when using the menu inside a form
          hidden_input: !is_nil(field),
          onchange:
            [
              "window.Prompt && Prompt.change(this",
              if prompt_options do
                ", #{prompt_options}"
              end,
              ")"
            ]
            |> Enum.join("")
        ]
      ])

    menu_id = id || "menu-" <> toggle_id

    menu_attrs =
      append_attributes(assigns.rest |> Map.drop([:id]), [
        [
          class: menu_class,
          "data-prompt": "",
          id: menu_id,
          "phx-hook": "Prompt"
        ],
        assigns[:is_fast] && ["data-isfast": ""],
        # Dialog and drawer specific:
        assigns[:is_modal] && ["data-ismodal": ""],
        assigns[:is_escapable] && ["data-isescapable": ""],
        assigns[:focus_first] && ["data-focusfirst": assigns[:focus_first]]
      ])

    backdrop_attrs =
      append_attributes([
        cond do
          assigns[:is_dark_backdrop] ->
            ["data-backdrop": "", "data-isdark": ""]

          assigns[:is_medium_backdrop] ->
            ["data-backdrop": "", "data-ismedium": ""]

          assigns[:is_light_backdrop] ->
            ["data-backdrop": "", "data-islight": ""]

          assigns[:is_backdrop] ->
            if is_menu, do: ["data-backdrop": "", "data-islight": ""], else: ["data-backdrop": ""]

          true ->
            []
        end
      ])

    touch_layer_attrs = [
      "data-touch": ""
    ]

    focus_wrap_id = "focus-wrap-#{id || generated_id}"

    %{
      toggle_attrs: toggle_attrs,
      checkbox_attrs: checkbox_attrs,
      menu_attrs: menu_attrs,
      backdrop_attrs: backdrop_attrs,
      touch_layer_attrs: touch_layer_attrs,
      focus_wrap_id: focus_wrap_id
    }
  end
end
