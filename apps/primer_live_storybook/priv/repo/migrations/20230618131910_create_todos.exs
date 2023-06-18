defmodule PrimerLiveStorybook.Repo.Migrations.CreateTodos do
  use Ecto.Migration

  def change do
    create table(:todos) do
      add(:statuses, {:array, :string}, default: [])

      timestamps()
    end
  end
end
