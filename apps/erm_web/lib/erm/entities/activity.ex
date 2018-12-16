defmodule Erm.Entities.Activity do
  use Ecto.Schema
  import Ecto.Changeset
  alias Erm.Entities.Activity
  alias Erm.Entities.Entity

  embedded_schema do
    field :content, :map
    field :date_from, :utc_datetime
    field :date_to, :utc_datetime
    field :description, :string
    field :status, :string
    field :title, :string
    field :type, :string
  end

  @doc false
  def changeset(%Activity{} = activity, attrs) do
    activity
    |> cast(attrs, [:type, :status, :title, :description, :content, :date_from, :date_to])
    |> validate_required([:type, :status, :title, :description, :content, :date_from, :date_to])
    |> Entity.cast_content(attrs)
  end
end
