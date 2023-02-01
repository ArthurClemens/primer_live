defmodule PrimerLive.Helpers.FormHelpers do
  @moduledoc false
  # Helper functions for components that interact with forms and changesets.

  use Phoenix.HTML

  # Map of input name to atom value that can be used by Phoenix.HTML.Form to render the appropriate input element.
  @text_input_types %{
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
  Returns a `PrimerLive.FieldState` struct to facilitate display logic in component rendering functions.

      iex> PrimerLive.Helpers.FormHelpers.field_state(:f, :first_name, nil)
      %PrimerLive.FieldState{valid?: false, changeset: nil, message: nil, field_errors: []}

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
      %PrimerLive.FieldState{valid?: true, changeset: %{action: :update, changes: %{first_name: "annette"}, data: nil, errors: [], valid?: true}, message: "always", field_errors: []}

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
      %PrimerLive.FieldState{valid?: false, changeset: %{action: :validate, changes: %{}, data: nil, errors: [first_name: {"can't be blank", [validation: :required]}], valid?: true}, message: "can't be blank", field_errors: ["can't be blank"]}

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
      %PrimerLive.FieldState{valid?: false, changeset: %{action: :update, changes: %{}, data: nil, errors: [first_name: {"can't be blank", [validation: :required]}], valid?: true}, message: "can't be blank", field_errors: ["can't be blank"]}
  """
  def field_state(form, field, validation_message_fn) do
    changeset = form_changeset(form)

    get_field_state_for_changeset(
      changeset,
      %PrimerLive.FieldState{},
      field,
      validation_message_fn
    )
  end

  defp get_field_state_for_changeset(changeset, field_state, _field, _validation_message_fn)
       when is_nil(changeset),
       do: field_state

  defp get_field_state_for_changeset(changeset, field_state, field, validation_message_fn) do
    with field_errors <- get_field_errors(changeset, field),
         valid? <- field_errors == [],
         field_state <- %{
           field_state
           | valid?: valid?,
             ignore_errors?: is_nil(changeset.action) && !valid?,
             field_errors: field_errors,
             changeset: changeset
         },
         message <-
           get_message(changeset.action, field_errors, field_state, validation_message_fn) do
      %{field_state | message: message}
    end
  end

  # changeset.action is nil
  defp get_message(nil, _field_errors, _field_state, _), do: nil

  # validation_message_fn is nil, field_errors is empty
  defp get_message(_changeset_action, field_errors, _field_state, nil) when field_errors == [],
    do: nil

  # validation_message_fn is nil, field_errors exists
  defp get_message(_changeset_action, field_errors, _field_state, nil) do
    [field_error | _rest] = field_errors
    field_error
  end

  # validation_message_fn exists
  defp get_message(_changeset_action, _field_errors, field_state, validation_message_fn) do
    validation_message_fn.(field_state)
  end

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
    |> Enum.map(fn {_error_field, {content, details}} ->
      interpolate_error_detials(content, details)
    end)
  end

  @doc """
  Get the input type atom from a name, e.g. "search" returns :search_input

  ## Tests

      iex> PrimerLive.Helpers.FormHelpers.text_input_type_as_atom("x")
      :text_input

      iex> PrimerLive.Helpers.FormHelpers.text_input_type_as_atom("text")
      :text_input

      iex> PrimerLive.Helpers.FormHelpers.text_input_type_as_atom("color")
      :color_input

  """
  def text_input_type_as_atom(type_name) do
    input_type = Map.get(@text_input_types, type_name)

    if is_nil(input_type), do: :text_input, else: input_type
  end

  defp interpolate_error_detials(content, details) do
    Enum.reduce(details, content, fn {key, value}, content ->
      String.replace(content, "%{#{key}}", "#{inspect(value)}")
    end)
  end
end
