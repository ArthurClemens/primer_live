defmodule PrimerLive.TestHelpers.Repo.Todo do
  @moduledoc false

  use Ecto.Schema

  schema "todos" do
    field(:statuses, {:array, :string}, default: [])

    timestamps()
  end
end
