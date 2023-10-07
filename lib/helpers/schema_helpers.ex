defmodule PrimerLive.Helpers.SchemaHelpers do
  @moduledoc false

  use Phoenix.Component
  alias PrimerLive.Helpers.{FormHelpers}

  @doc """
  Validates attribute `form`.
  Allowed values:
  - nil
  - atom
  - Phoenix.HTML.Form
  - a struct whose stringified type contains "Form"
  """
  def validate_is_form(assigns) do
    form = assigns[:form]

    cond do
      is_nil(form) -> true
      is_atom(form) -> true
      FormHelpers.is_form(form) -> true
      true -> {:error, "attr form: invalid value"}
    end
  end
end
