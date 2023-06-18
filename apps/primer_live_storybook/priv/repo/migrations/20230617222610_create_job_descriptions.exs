defmodule PrimerLiveStorybook.Repo.Migrations.CreateJobDescriptions do
  use Ecto.Migration

  def change do
    create table(:job_descriptions) do
      add(:roles, {:array, :string}, default: [])

      timestamps()
    end
  end
end
