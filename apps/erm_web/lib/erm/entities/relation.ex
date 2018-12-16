defmodule Erm.Entities.Relation do
  use Ecto.Schema
  import Ecto.Changeset


  schema "entity_relations" do
    field :content, :map
    field :title, :string
    field :type, :string
    field :date, :utc_datetime
    field :valid_from, :utc_datetime
    field :valid_to, :utc_datetime

    belongs_to :entity_from, Erm.Entities.Entity
    belongs_to :entity_to, Erm.Entities.Entity

    timestamps()
  end

  @doc false
  def changeset(relation, attrs) do
    relation
    |> cast(attrs, [:type, :title, :content, :date, :valid_from, :valid_to, :entity_from_id, :entity_to_id])
    |> validate_required([:type])
  end
end
