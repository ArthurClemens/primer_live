defmodule PrimerLive.Options.FormGroup.Classes do
  use Options

  @moduledoc """
  Options for `classes` in `PrimerLive.Options.FormGroup`.

  | **Classname** | **Description**               |
  | ------------- | ----------------------------- |
  | `form_group`  | The form group element class. |
  | `header`      | The header element class.     |
  | `body`        | The body element class.       |
  | `note`        | The note element class.       |
  """

  typed_embedded_schema do
    field(:form_group, :string)
    field(:header, :string)
    field(:body, :string)
    field(:note, :string)
  end

  @impl Options
  def changeset(struct, attrs \\ %{}) do
    struct
    |> cast(attrs, [:form_group, :header, :body, :note])
  end
end

defmodule PrimerLive.Options.FormGroup do
  use Options

  alias PrimerLive.Options.FormGroup.{Classes}

  @moduledoc """
  Options for `form_group` in `PrimerLive.Options.TextInput`.

  | **Name**   | **Type** | **Validation** | **Default** | **Description**                                                                                                                                           |
  | ---------- | -------- | -------------- | ----------- | --------------------------------------------------------------------------------------------------------------------------------------------------------- |
  | `class`    | `string` | -              | -           | Additional classname.                                                                                                                                     |
  | `classes`  | `map`    | -              | -           | Map of classnames. Any provided value will be appended to the default classnames. See `PrimerLive.Options.FormGroup.Classes`.                             |
  | `header`   | `slot`   | -              | -           | Header text.                                                                                                                                              |

  ## Internal

  Internal options that are passed from input component to `form_group`.

  | **Name**            | **Type**                        | **Validation** | **Default** | **Description**                                                                                                                                                                                                                                                        |
  | ------------------- | ------------------------------- | -------------- | ----------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
  | `inner_block`       | `slot`                          | required       | -           | Form group content, usually a form input.                                                                                                                                                                                                                              |
  | `field`             | `atom` or `string`              | required       | -           | Field name.                                                                                                                                                                                                                                                            |
  | `form`              | `Phoenix.HTML.Form` or `atom`   | required       | -           | Either a [Phoenix.HTML.Form](https://hexdocs.pm/phoenix_html/Phoenix.HTML.Form.html) or an atom.                                                                                                                                                                       |
  | `validation_status` | `{:error, msg}` or `{:ok, msg}` | -              | -           | Only when a form changeset is available. The status is derived from the value of `changeset.valid?`. The message text is received from `PrimerLive.Options.TextInput` option `get_validation_message`, otherwise from the first of the form changeset errors (if any). |
  """

  typed_embedded_schema do
    # Slots
    field(:inner_block, :any, virtual: true)
    field(:header, :any, virtual: true)
    # Required options
    field(:field, :any, virtual: true)
    field(:form, :any, virtual: true)
    # Optional options
    field(:class, :string)
    field(:validation_status, :any, virtual: true)
    # Embedded options
    embeds_one(:classes, Classes)
  end

  @impl Options
  def changeset(struct, attrs \\ %{}) do
    struct
    |> cast(attrs, [
      :class,
      :validation_status,
      :field,
      :form,
      :header,
      :inner_block
    ])
    |> cast_embed_with_defaults(attrs, :classes, %{})
    |> validate_required([:inner_block, :field, :form])
    |> validate_validation_status(attrs)
  end

  defp validate_validation_status(changeset, %{:validation_status => value} = _attrs) do
    case value do
      {:ok, _} -> changeset
      {:error, _} -> changeset
      _ -> add_error(changeset, :validation_status, "invalid value")
    end
  end

  defp validate_validation_status(changeset, _) do
    changeset
  end
end

defmodule PrimerLive.Options.TextInput do
  use Options

  alias PrimerLive.Options.FormGroup

  @input_types %{
    "color" => :color_input,
    "date" => :date_input,
    "datetime-local" => :datetime_local_input,
    "email" => :email_input,
    "file" => :file_input,
    "hidden" => :hidden_input,
    "number" => :number_input,
    "password" => :password_input,
    "range" => :range_input,
    "search" => :search_input,
    "telephone" => :telephone_input,
    "text" => :text_input,
    "time" => :time_input,
    "url" => :url_input
  }

  @moduledoc """
  Options for component `PrimerLive.Components.text_input/1`.

  | **Name**                  | **Type**                      | **Validation**                                                                                                                                        | **Default** | **Description**                                                                                                                                                                   |
  | ------------------------- | ----------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------- | ----------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
  | `field`                   | `atom` or `string`            | required for `form_group`                                                                                                                             | -           | Field name.                                                                                                                                                                       |
  | `form`                    | `Phoenix.HTML.Form` or `atom` | required for `form_group`                                                                                                                             | -           | Either a [Phoenix.HTML.Form](https://hexdocs.pm/phoenix_html/Phoenix.HTML.Form.html) or an atom.                                                                                  |
  | `form_group`              | `boolean` or `map`            | -                                                                                                                                                     | -           | Options for `PrimerLive.Options.FormGroup`. Passing these options, or just passing `true`, will create a "form group" element that wraps the label, the input and any help texts. |
  | `class`                   | `string`                      | -                                                                                                                                                     | -           | Additional classname.                                                                                                                                                             |
  | `is_contrast`             | `boolean`                     | -                                                                                                                                                     | false       | Changes the background color to light gray.                                                                                                                                       |
  | `is_full_width`           | `boolean`                     | -                                                                                                                                                     | false       | Full width input.                                                                                                                                                                 |
  | `is_hide_webkit_autofill` | `boolean`                     | -                                                                                                                                                     | false       | Hide WebKit's contact info autofill icon.                                                                                                                                         |
  | `is_large`                | `boolean`                     | -                                                                                                                                                     | false       | Larger input.                                                                                                                                                                     |
  | `is_small`                | `boolean`                     | -                                                                                                                                                     | false       | Smaller input.                                                                                                                                                                    |
  | `type`                    | `string`                      | "color", "date", "datetime-local", "email", "file", "hidden", "number", "password", "range", "search", "telephone", "text", "time", "url" | "text"      | Text input type.                                                                                                                                                                  |
  | `get_validation_message`  | `fun changeset -> string`     | -                                                                                                                                                     | -           | Function to write a custom error message. The function receives for form's changeset data (type `Ecto.Changeset`) and returns a string for error message.                         |
  """

  typed_embedded_schema do
    field(:class, :string)
    field(:field, :any, virtual: true)
    field(:form, :any, virtual: true)
    field(:get_validation_message, :any, virtual: true)
    field(:is_contrast, :boolean, default: false)
    field(:is_full_width, :boolean, default: false)
    field(:is_hide_webkit_autofill, :boolean, default: false)
    field(:is_large, :boolean, default: false)
    field(:is_small, :boolean, default: false)
    field(:type, :string, default: "text")
    # Embedded options
    embeds_one(:form_group, FormGroup)
  end

  @impl Options
  @spec changeset(
          {map, map}
          | %{
              :__struct__ => atom | %{:__changeset__ => map, optional(any) => any},
              optional(atom) => any
            },
          %{optional(:__struct__) => none, optional(atom | binary) => any}
        ) :: Ecto.Changeset.t()
  def changeset(struct, attrs \\ %{}) do
    struct
    |> cast(attrs, [
      :class,
      :field,
      :form,
      :get_validation_message,
      :is_contrast,
      :is_full_width,
      :is_hide_webkit_autofill,
      :is_large,
      :is_small,
      :type
    ])
    |> cast_form_group(attrs)
    |> validate_inclusion(:type, Map.keys(@input_types))
    |> validate_form(attrs)
  end

  # Conditionally embeds a value for form_group.
  defp cast_form_group(changeset, attrs) do
    value = attrs[:form_group]

    defaults = %FormGroup{
      form: attrs[:form],
      field: attrs[:field]
    }

    cond do
      value == true ->
        # Initially true: embed a default map with `form` and `field`
        changeset
        |> put_embed(:form_group, defaults)

      is_map(value) ->
        # A map: merge it with the default values containing `form` and `field`
        changeset
        |> put_embed(:form_group, Map.merge(defaults, value))

      true ->
        # Otherwise, pass the changeset unmodified
        changeset
    end
  end

  defp validate_form(changeset, attrs) do
    changeset
    |> validate_type(attrs, :form, fn value ->
      cond do
        is_nil(value) -> true
        is_atom(value) -> true
        is_phoenix_form(value) -> true
        true -> false
      end
    end)
  end

  @doc false
  # Get the input type atom from a name, e.g. "search" returns :search_input
  def input_type(type_name) do
    input_type = Map.get(@input_types, type_name)

    if is_nil(input_type), do: :text_input, else: input_type
  end
end
