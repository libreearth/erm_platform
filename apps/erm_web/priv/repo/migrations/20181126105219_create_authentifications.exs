defmodule Erm.Repo.Migrations.CreateAuthentifications do
  use Ecto.Migration

  def change do
    create table(:authentifications) do
      add :email, :string
      add :password_hash, :string
      add :provider, :string
      add :uid, :string
      add :verified, :boolean, default: false, null: false
      add :partner_id, references(:entities, on_delete: :nothing), null: false

      timestamps()
    end

    create unique_index(:authentifications, [:partner_id])
    create index(:authentifications, [:email, :password_hash])
  end
end
