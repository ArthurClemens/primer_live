defmodule PrimerLiveTest.JobDescription do
  use Ecto.Schema

  schema "job_descriptions" do
    field(:roles, {:array, :string}, default: [])

    timestamps()
  end
end
