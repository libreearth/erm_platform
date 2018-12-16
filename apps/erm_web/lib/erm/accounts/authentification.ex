defmodule Erm.Accounts.Authentification do
  use Ecto.Schema
  import Ecto.Changeset
  alias Erm.Accounts.Authentification
  alias Erm.Entities.Entity, as: Partner


  schema "authentifications" do
    field :email, :string
    field :password_hash, :string
    field :password, :string, virtual: true
    field :provider, :string
    field :uid, :string
    field :verified, :boolean, default: false
    field :is_new?, :boolean, virtual: true
    belongs_to :partner, Partner

    timestamps()
  end

  @oauth2_fields ~w(email provider uid is_new?)a

  @doc false
  def changeset(authentification, attrs) do
    authentification
    |> cast(attrs, [:email, :password])
    |> validate_required([:email, :password])
    |> unique_constraint(:email)
  end

  def oauth2_changeset(%Authentification{} = authentification, params) do
    authentification
    |> cast(params, @oauth2_fields)
    |> validate_required(@oauth2_fields)
    |> unique_constraint(:email)
    |> IO.inspect()
    |> cast_assoc(:partner, required: true, with: &partner_changeset/2)
  end

  defp partner_changeset(partner, attrs) do
    #%Partner{partner | type: "partner"}
    #|> cast(attrs, [:title, :description])
    Partner.changeset(%Partner{partner | type: "partner"}, attrs)
  end

  # defp ensure_email_is_valid_or_clear(email) do
  #   case Regex.run(~r/.+@.+/, email) do
  #     nil ->
  #       nil

  #     [email] ->
  #       email
  #   end
  # end
end
