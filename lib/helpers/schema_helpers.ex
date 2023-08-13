defmodule PrimerLive.Helpers.SchemaHelpers do
  @moduledoc false

  use Phoenix.Component

  @doc """
  Validates attribute `form`.
  Allowed values:
  - nil
  - atom
  - Phoenix.HTML.Form
  """
  def validate_is_form(assigns) do
    form = assigns[:form]

    cond do
      is_nil(form) -> true
      is_atom(form) -> true
      is_phoenix_form(form) -> true
      true -> {:error, "attr form: invalid value"}
    end
  end

  defp is_phoenix_form(%Phoenix.HTML.Form{}), do: true
  defp is_phoenix_form(_), do: false
end
