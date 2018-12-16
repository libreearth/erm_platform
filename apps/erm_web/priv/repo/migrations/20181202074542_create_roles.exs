defmodule Erm.Repo.Migrations.CreateRoles do
  use Ecto.Migration

  def change do
    create table(:roles) do
      add :type, :string
      add :name, :string
      add :description, :string
      add :valid_from, :utc_datetime
      add :valid_to, :utc_datetime
      add :content, :map
      add :entity_id, references(:entities, on_delete: :nothing), null: false

      timestamps()
    end

    create unique_index(:roles, [:entity_id])

  end
end
