defmodule PrimerLiveTest.JobDescriptions do
  use Ecto.Schema
  import PrimerLiveTest.ChangesetHelpers

  alias PrimerLiveTest.JobDescription
  alias PrimerLiveTest.Repo

  @doc """
  Returns the list of job descriptions.

  ## Examples

      iex> list()
      [%JobDescription{}, ...]

  """
  def list do
    Repo.all(JobDescription)
  end

  @doc """
  Gets a single job description.

  Raises `Ecto.NoResultsError` if the JobDescription does not exist.

  ## Examples

      iex> get!(123)
      %JobDescription{}

      iex> get!(456)
      ** (Ecto.NoResultsError)

  """
  def get!(id), do: Repo.get!(JobDescription, id)

  @doc """
  Creates a job description.

  ## Examples

      iex> create(%{field: value})
      {:ok, %JobDescription{}}

      iex> create(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create(attrs \\ %{}) do
    %JobDescription{}
    |> changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a job description.

  ## Examples

      iex> update(job description, %{field: new_value})
      {:ok, %JobDescription{}}

      iex> update(job description, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update(%JobDescription{} = job_description, attrs) do
    job_description
    |> changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a job description.

  ## Examples

      iex> delete(job description)
      {:ok, %JobDescription{}}

      iex> delete(job description)
      {:error, %Ecto.Changeset{}}

  """
  def delete(%JobDescription{} = job_description) do
    Repo.delete(job_description)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking job description changes.

  ## Examples

      iex> change(job description)
      %Ecto.Changeset{data: %JobDescription{}}

  """
  def change(%JobDescription{} = job_description, attrs \\ %{}) do
    changeset(job_description, attrs)
  end

  def init() do
    change(%JobDescription{})
  end

  @role_options [
    {"Admin", "admin"},
    {"Editor", "editor"},
    {"Reader", "reader"}
  ]

  @valid_roles Enum.map(@role_options, fn {_text, val} -> val end)

  def role_options, do: @role_options

  @allowed_fields [
    :roles
  ]

  @required_fields [
    :roles
  ]

  defp changeset(job_description, attrs) do
    job_description
    |> Ecto.Changeset.cast(attrs, @allowed_fields)
    |> clean_and_validate_array(:roles, @valid_roles, "false")
    |> Ecto.Changeset.validate_required(@required_fields)
  end
end
