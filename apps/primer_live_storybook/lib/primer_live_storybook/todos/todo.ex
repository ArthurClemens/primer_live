defmodule PrimerLiveStorybook.Todo do
  use Ecto.Schema

  schema "todos" do
    field(:statuses, {:array, :string}, default: [])

    timestamps()
  end
end
