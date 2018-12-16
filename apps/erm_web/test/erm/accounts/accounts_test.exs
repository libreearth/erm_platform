# defmodule Erm.AccountsTest do
#   use Erm.DataCase

#   alias Erm.Accounts

#   describe "authentifications" do
#     alias Erm.Accounts.Authentification

#     @valid_attrs %{email: "some email", password_hash: "some password_hash", provider: "some provider", uid: "some uid", verified: true}
#     @update_attrs %{email: "some updated email", password_hash: "some updated password_hash", provider: "some updated provider", uid: "some updated uid", verified: false}
#     @invalid_attrs %{email: nil, password_hash: nil, provider: nil, uid: nil, verified: nil}

#     def authentification_fixture(attrs \\ %{}) do
#       {:ok, authentification} =
#         attrs
#         |> Enum.into(@valid_attrs)
#         |> Accounts.create_authentification()

#       authentification
#     end

#     test "list_authentifications/0 returns all authentifications" do
#       authentification = authentification_fixture()
#       assert Accounts.list_authentifications() == [authentification]
#     end

#     test "get_authentification!/1 returns the authentification with given id" do
#       authentification = authentification_fixture()
#       assert Accounts.get_authentification!(authentification.id) == authentification
#     end

#     test "create_authentification/1 with valid data creates a authentification" do
#       assert {:ok, %Authentification{} = authentification} = Accounts.create_authentification(@valid_attrs)
#       assert authentification.email == "some email"
#       assert authentification.password_hash == "some password_hash"
#       assert authentification.provider == "some provider"
#       assert authentification.uid == "some uid"
#       assert authentification.verified == true
#     end

#     test "create_authentification/1 with invalid data returns error changeset" do
#       assert {:error, %Ecto.Changeset{}} = Accounts.create_authentification(@invalid_attrs)
#     end

#     test "update_authentification/2 with valid data updates the authentification" do
#       authentification = authentification_fixture()
#       assert {:ok, %Authentification{} = authentification} = Accounts.update_authentification(authentification, @update_attrs)
#       assert authentification.email == "some updated email"
#       assert authentification.password_hash == "some updated password_hash"
#       assert authentification.provider == "some updated provider"
#       assert authentification.uid == "some updated uid"
#       assert authentification.verified == false
#     end

#     test "update_authentification/2 with invalid data returns error changeset" do
#       authentification = authentification_fixture()
#       assert {:error, %Ecto.Changeset{}} = Accounts.update_authentification(authentification, @invalid_attrs)
#       assert authentification == Accounts.get_authentification!(authentification.id)
#     end

#     test "delete_authentification/1 deletes the authentification" do
#       authentification = authentification_fixture()
#       assert {:ok, %Authentification{}} = Accounts.delete_authentification(authentification)
#       assert_raise Ecto.NoResultsError, fn -> Accounts.get_authentification!(authentification.id) end
#     end

#     test "change_authentification/1 returns a authentification changeset" do
#       authentification = authentification_fixture()
#       assert %Ecto.Changeset{} = Accounts.change_authentification(authentification)
#     end
#   end
# end
