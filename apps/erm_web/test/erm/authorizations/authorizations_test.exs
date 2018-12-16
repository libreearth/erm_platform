defmodule Erm.AuthorizationsTest do
  use Erm.DataCase

  alias Erm.Authorizations

  describe "roles" do
    alias Erm.Authorizations.Role

    @valid_attrs %{content: %{}, description: "some description", name: "some name", type: "some type", valid_from: "2010-04-17T14:00:00Z", valid_to: "2010-04-17T14:00:00Z"}
    @update_attrs %{content: %{}, description: "some updated description", name: "some updated name", type: "some updated type", valid_from: "2011-05-18T15:01:01Z", valid_to: "2011-05-18T15:01:01Z"}
    @invalid_attrs %{content: nil, description: nil, name: nil, type: nil, valid_from: nil, valid_to: nil}

    def role_fixture(attrs \\ %{}) do
      {:ok, role} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Authorizations.create_role()

      role
    end

    test "list_roles/0 returns all roles" do
      role = role_fixture()
      assert Authorizations.list_roles() == [role]
    end

    test "get_role!/1 returns the role with given id" do
      role = role_fixture()
      assert Authorizations.get_role!(role.id) == role
    end

    test "create_role/1 with valid data creates a role" do
      assert {:ok, %Role{} = role} = Authorizations.create_role(@valid_attrs)
      assert role.content == %{}
      assert role.description == "some description"
      assert role.name == "some name"
      assert role.type == "some type"
      assert role.valid_from == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
      assert role.valid_to == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
    end

    test "create_role/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Authorizations.create_role(@invalid_attrs)
    end

    test "update_role/2 with valid data updates the role" do
      role = role_fixture()
      assert {:ok, %Role{} = role} = Authorizations.update_role(role, @update_attrs)
      assert role.content == %{}
      assert role.description == "some updated description"
      assert role.name == "some updated name"
      assert role.type == "some updated type"
      assert role.valid_from == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
      assert role.valid_to == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
    end

    test "update_role/2 with invalid data returns error changeset" do
      role = role_fixture()
      assert {:error, %Ecto.Changeset{}} = Authorizations.update_role(role, @invalid_attrs)
      assert role == Authorizations.get_role!(role.id)
    end

    test "delete_role/1 deletes the role" do
      role = role_fixture()
      assert {:ok, %Role{}} = Authorizations.delete_role(role)
      assert_raise Ecto.NoResultsError, fn -> Authorizations.get_role!(role.id) end
    end

    test "change_role/1 returns a role changeset" do
      role = role_fixture()
      assert %Ecto.Changeset{} = Authorizations.change_role(role)
    end
  end
end
