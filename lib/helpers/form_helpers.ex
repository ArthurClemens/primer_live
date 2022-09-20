defmodule PrimerLive.Helpers.FormHelpers do
  use Phoenix.HTML

  @moduledoc false

  @doc """
  Returns field error data.
  Returns nil if no errors are found, or if the form does not contain an `error` attribute.
  """
  def error_data(form, field) do
    try do
      form.errors
      |> Keyword.get_values(field)
    rescue
      _ -> nil
    end
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
  """
  def field_errors(changeset, field) do
    changeset.errors
    |> Enum.filter(fn {error_field, _content} -> error_field == field end)
    |> Enum.map(fn {_error_field, {content, _details}} -> content end)
  end

  @doc """
  Returns a map of validation data to facilitate display logic in component rendering functions.
  """
  def validation_data(form, field, get_validation_message_fn) do
    status = validation_status(form, field, get_validation_message_fn)

    {is_error, message, has_message} =
      case status do
        {:ok, msg} -> {false, msg, !is_nil(msg)}
        {:error, msg} -> {true, msg, !is_nil(msg)}
      end

    validation_message_id = if has_message, do: "#{field}-validation", else: nil

    %PrimerLive.Options.ValidationData{
      is_error: is_error,
      message: message,
      has_message: has_message,
      validation_message_id: validation_message_id
    }
  end

  # Returns an error tuple {:ok, message} or {:error, message}, or nil if no form changeset exists.
  # The message is either taken from input attribute `get_validation_message` or from the changeset error message.
  defp validation_status(form, field, get_validation_message_fn) do
    changeset = form_changeset(form)

    case is_nil(changeset) do
      true ->
        {:ok, nil}

      false ->
        custom_validation_message =
          case is_nil(get_validation_message_fn) do
            true -> nil
            false -> get_validation_message_fn.(changeset)
          end

        case is_nil(custom_validation_message) do
          true ->
            field_errors = field_errors(changeset, field)

            case field_errors do
              [field_error | _rest] -> {:error, field_error}
              _ -> {:ok, nil}
            end

          false ->
            case changeset.valid? do
              true -> {:ok, custom_validation_message}
              false -> {:error, custom_validation_message}
            end
        end
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
