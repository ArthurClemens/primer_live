defmodule PrimerLive.Helpers.FormHelpers do
  use Phoenix.HTML

  @moduledoc false
  # Helper functions for components that interact with forms and changesets.

  @doc """
  Returns the form changeset (from form.source).
  Returns nil if no changeset is found,
  """
  def form_changeset(form) do
    try do
      form.source
    rescue
      _ -> nil
    end
  end

  @doc """
  Returns all error for a given field from a changeset.

      iex> PrimerLive.Helpers.FormHelpers.get_field_errors(
      ...>   %{
      ...>     action: :update,
      ...>     changes: %{},
      ...>     errors: [],
      ...>     data: nil,
      ...>     valid?: true
      ...>   }, :first_name)
      []

      iex> PrimerLive.Helpers.FormHelpers.get_field_errors(
      ...>   %{
      ...>     action: :update,
      ...>     changes: %{},
      ...>     errors: [
      ...>       first_name: {"can't be blank", [validation: :required]},
      ...>       work_experience: {"invalid value", [validation: :required]}
      ...>     ],
      ...>     data: nil,
      ...>     valid?: true
      ...>   }, :first_name)
      ["can't be blank"]

      iex> PrimerLive.Helpers.FormHelpers.get_field_errors(
      ...>   %{
      ...>     action: :update,
      ...>     changes: %{},
      ...>     errors: [
      ...>       first_name: {"can't be blank", [validation: :required]},
      ...>       work_experience: {"invalid value", [validation: :required]}
      ...>     ],
      ...>     data: nil,
      ...>     valid?: true
      ...>   }, :work_experience)
      ["invalid value"]
  """
  def get_field_errors(changeset, field) do
    changeset.errors
    |> Enum.filter(fn {error_field, _content} -> error_field == field end)
    |> Enum.map(fn {_error_field, {content, _details}} -> content end)
  end

  @doc """
  Returns a `PrimerLive.FieldState` struct to facilitate display logic in component rendering functions.

      iex> PrimerLive.Helpers.FormHelpers.field_state(:f, :first_name, nil)
      %PrimerLive.FieldState{valid?: false, changeset: nil, message: nil, message_id: nil, field_errors: []}

      # If validation_message_fn returns a string it will be added to FieldState, regardless of the changeset action value:
      iex> PrimerLive.Helpers.FormHelpers.field_state(
      ...>   %Phoenix.HTML.Form{
      ...>     source: %{
      ...>       action: :update,
      ...>       changes: %{first_name: "annette"},
      ...>       errors: [],
      ...>       data: nil,
      ...>       valid?: true
      ...>     },
      ...>   },
      ...>   :first_name, fn _field_state -> "always" end)
      %PrimerLive.FieldState{valid?: true, changeset: %{action: :update, changes: %{first_name: "annette"}, data: nil, errors: [], valid?: true}, message: "always", message_id: "first_name-validation", field_errors: []}

      # If changeset action is :validate and no validation_message_fn is provided, the default field error is added to FieldState:
      iex> PrimerLive.Helpers.FormHelpers.field_state(
      ...>   %Phoenix.HTML.Form{
      ...>     source: %{
      ...>       action: :validate,
      ...>       changes: %{},
      ...>       errors: [first_name: {"can't be blank", [validation: :required]}],
      ...>       data: nil,
      ...>       valid?: true
      ...>     },
      ...>   },
      ...>   :first_name, nil)
      %PrimerLive.FieldState{valid?: false, changeset: %{action: :validate, changes: %{}, data: nil, errors: [first_name: {"can't be blank", [validation: :required]}], valid?: true}, message: "can't be blank", message_id: "first_name-validation", field_errors: ["can't be blank"]}

      # If changeset action is :update and no validation_message_fn is provided, no message is added to FieldState:
      iex> PrimerLive.Helpers.FormHelpers.field_state(
      ...>   %Phoenix.HTML.Form{
      ...>     source: %{
      ...>       action: :update,
      ...>       changes: %{},
      ...>       errors: [first_name: {"can't be blank", [validation: :required]}],
      ...>       data: nil,
      ...>       valid?: true
      ...>     },
      ...>   },
      ...>   :first_name, nil)
      %PrimerLive.FieldState{valid?: false, changeset: %{action: :update, changes: %{}, data: nil, errors: [first_name: {"can't be blank", [validation: :required]}], valid?: true}, message: nil, message_id: nil, field_errors: ["can't be blank"]}
  """
  def field_state(form, field, validation_message_fn) do
    field_state = get_field_state(form, field, validation_message_fn)

    case is_nil(field_state.message) do
      true -> field_state
      false -> %{field_state | message_id: "#{field}-validation"}
    end
  end

  defp get_field_state(form, field, validation_message_fn) do
    changeset = form_changeset(form)
    field_state = %PrimerLive.FieldState{}

    case is_nil(changeset) do
      true ->
        field_state

      false ->
        field_errors = get_field_errors(changeset, field)
        valid? = Enum.count(field_errors) == 0

        field_state = %{
          field_state
          | valid?: valid?,
            field_errors: field_errors,
            changeset: changeset
        }

        message =
          case is_nil(validation_message_fn) do
            true ->
              case changeset.action === :validate do
                true ->
                  [field_error | _rest] = field_errors
                  field_error

                false ->
                  nil
              end

            false ->
              validation_message_fn.(field_state)
          end

        %{field_state | message: message}
    end
  end

  # Map of input name to atom value that can be used by Phoenix.HTML.Form to render the appropriate input element.
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
    "textarea" => :textarea,
    "time" => :time_input,
    "url" => :url_input
  }

  @doc """
  Get the input type atom from a name, e.g. "search" returns :search_input

  ## Examples

      iex> PrimerLive.Helpers.FormHelpers.input_type_as_atom("x")
      :text_input

      iex> PrimerLive.Helpers.FormHelpers.input_type_as_atom("text")
      :text_input

      iex> PrimerLive.Helpers.FormHelpers.input_type_as_atom("color")
      :color_input

  """
  def input_type_as_atom(type_name) do
    input_type = Map.get(@input_types, type_name)

    if is_nil(input_type), do: :text_input, else: input_type
  end
end
