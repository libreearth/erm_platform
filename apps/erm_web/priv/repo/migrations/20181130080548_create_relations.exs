defmodule Erm.Repo.Migrations.CreateRelations do
  use Ecto.Migration

  def change do
    create table(:entity_relations) do
      add :type, :string
      add :title, :string
      add :content, :map
      add :date, :utc_datetime
      add :valid_from, :utc_datetime
      add :valid_to, :utc_datetime

      add :entity_from_id, references(:entities, on_delete: :nothing), null: false
      add :entity_to_id, references(:entities, on_delete: :nothing), null: false

      timestamps()
    end

        create index(:entity_relations, [:type, :entity_from_id])

        create index(:entity_relations, [:type, :entity_to_id])


        create unique_index(:entity_relations, [:type, :entity_from_id, :entity_to_id])

  end
end
