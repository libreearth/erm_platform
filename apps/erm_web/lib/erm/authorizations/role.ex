defmodule Erm.Authorizations.Role do
  use Ecto.Schema
  import Ecto.Changeset


  schema "roles" do
    field :content, :map
    field :description, :string
    field :name, :string
    field :type, :string
    field :valid_from, :utc_datetime
    field :valid_to, :utc_datetime

    belongs_to :entity, Erm.Entities.Entity

    timestamps()
  end

  @doc false
  def changeset(role, attrs) do
    role
    |> cast(attrs, [:type, :name, :description, :valid_from, :valid_to, :content])
    |> validate_required([:type, :name, :description, :valid_from, :valid_to, :content])
  end
end
