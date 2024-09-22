defmodule PrimerLive.TestHelpers.Repo.User do
  @moduledoc false

  use Ecto.Schema

  schema "users" do
    field(:first_name, :string)
    field(:work_experience, :string)
    field(:available_for_hire, :boolean)

    timestamps()
  end
end
