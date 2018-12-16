defmodule Erm.Repo.Migrations.CreateEntities do
  use Ecto.Migration

  def change do
    create table(:entities) do
      add :type, :string
      add :title, :string
      add :description, :string
      add :content, :map
      add :geom, :geometry
      add :h3id, :string
      add :can_action, :boolean, default: false

      timestamps()
    end

  end
end
