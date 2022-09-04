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

  def get_validation_status_and_message(form, field, get_validation_message_fn) do
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

  @doc """
  Returns all error for a given field from a changeset.
  """
  def field_errors(changeset, field) do
    changeset.errors
    |> Enum.filter(fn {error_field, _content} -> error_field == field end)
    |> Enum.map(fn {_error_field, {content, _details}} -> content end)
  end
end
