defmodule PrimerLive.Helpers.FormHelpers do
  use Phoenix.HTML

  @moduledoc false

  @doc """
  Returns the first field error.
  Returns nil if no errors are found, or if the form does not contain an `error` attribute.
  """
  def error_message(form, field) do
    try do
      error_data(form, field)
      |> Enum.map(fn {msg, _rest} -> msg end)
      |> hd
    rescue
      _ -> nil
    end
  end

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
end
