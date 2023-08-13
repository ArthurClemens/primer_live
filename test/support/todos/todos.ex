defmodule PrimerLive.TestHelpers.Repo.Todos do
  @moduledoc false

  import Ecto.Changeset, except: [change: 1]
  alias PrimerLive.TestHelpers.Repo.Todo

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking to do item changes.

  ## Examples

      iex> change(to do item)
      %Ecto.Changeset{data: %Todo{}}

  """
  def change(%Todo{} = todo, attrs \\ %{}) do
    todo
    |> changeset(attrs)
  end

  def init() do
    change(%Todo{})
  end

  @status_options [
    {"In progress", "in-progress"},
    {"Needs review", "needs-review"},
    {"Complete", "complete"}
  ]

  def status_options, do: @status_options

  @allowed_fields [
    :statuses
  ]

  @required_fields [
    :statuses
  ]

  defp changeset(todo, attrs) do
    todo
    |> cast(attrs, @allowed_fields)
    |> validate_required(@required_fields)
    |> validate_empty(:statuses, "must select a status")
  end

  defp validate_empty(changeset, field, message) do
    values = get_field(changeset, field)

    if Enum.empty?(values) do
      add_error(changeset, field, message)
    else
      changeset
    end
  end
end
