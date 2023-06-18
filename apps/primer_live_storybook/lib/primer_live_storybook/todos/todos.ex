defmodule PrimerLiveStorybook.Todos do
  use Ecto.Schema
  import PrimerLiveStorybook.ChangesetHelpers

  alias PrimerLiveStorybook.Todo
  alias PrimerLiveStorybook.Repo

  @doc """
  Returns the list of to do items.

  ## Examples

      iex> list()
      [%Todo{}, ...]

  """
  def list do
    Repo.all(Todo)
  end

  @doc """
  Gets a single to do item.

  Raises `Ecto.NoResultsError` if the Todo does not exist.

  ## Examples

      iex> get!(123)
      %Todo{}

      iex> get!(456)
      ** (Ecto.NoResultsError)

  """
  def get!(id), do: Repo.get!(Todo, id)

  @doc """
  Creates a to do item.

  ## Examples

      iex> create(%{field: value})
      {:ok, %Todo{}}

      iex> create(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create(attrs \\ %{}) do
    %Todo{}
    |> changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a to do item.

  ## Examples

      iex> update(to do item, %{field: new_value})
      {:ok, %Todo{}}

      iex> update(to do item, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update(%Todo{} = todo, attrs) do
    todo
    |> changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a to do item.

  ## Examples

      iex> delete(to do item)
      {:ok, %Todo{}}

      iex> delete(to do item)
      {:error, %Ecto.Changeset{}}

  """
  def delete(%Todo{} = todo) do
    Repo.delete(todo)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking to do item changes.

  ## Examples

      iex> change(to do item)
      %Ecto.Changeset{data: %Todo{}}

  """
  def change(%Todo{} = todo, attrs \\ %{}) do
    changeset(todo, attrs)
  end

  def init() do
    change(%Todo{})
  end

  @status_options [
    {"In progress", "in-progress"},
    {"Needs review", "needs-review"},
    {"Complete", "complete"}
  ]

  @valid_statuses Enum.map(@status_options, fn {_text, val} -> val end)

  def status_options, do: @status_options

  @allowed_fields [
    :statuses
  ]

  @required_fields [
    :statuses
  ]

  defp changeset(todo, attrs) do
    todo
    |> Ecto.Changeset.cast(attrs, @allowed_fields)
    |> clean_and_validate_array(:statuss, @valid_statuss, "false")
    |> Ecto.Changeset.validate_required(@required_fields)
  end
end
