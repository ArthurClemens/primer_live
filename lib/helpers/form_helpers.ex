defmodule PrimerLive.Helpers.FormHelpers do
  use Phoenix.HTML

  @moduledoc false

  def first_field_error(form, field) do
    case form.errors
         |> Enum.filter(fn {k, _v} -> k == field end) do
      [error] -> error
      _ -> nil
    end
  end

  use Phoenix.HTML

  @doc """
  Generates a tag for inlined form input errors.
  """
  def error_tag(form, field) do
    Enum.map(Keyword.get_values(form.errors, field), fn error ->
      content_tag(:div, error,
        class: "form-message error",
        phx_feedback_for: input_name(form, field),
        id: "#{input_name(form, field)}-validation"
      )
    end)
  end
end
