defmodule Erm.Repo.Migrations.AddStatusDatesToEntity do
  use Ecto.Migration

  def change do
    alter table(:entities) do
      add :status, :string
      add :date_from, :utc_datetime
      add :date_to, :utc_datetime
    end

  end
end
