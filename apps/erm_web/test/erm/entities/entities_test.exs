defmodule Erm.EntitiesTest do
  use Erm.DataCase

  alias Erm.Entities

  describe "entities" do
    alias Erm.Entities.Entity

    @valid_attrs %{content: %{}, description: "some description", h3id: "some h3id", geom: %Geo.Point{coordinates: {30, -90}, srid: 4326}, title: "some title", type: "some type", can_action: false}
    @update_attrs %{content: %{}, description: "some updated description", h3id: "some updated h3id", geom: %Geo.Point{coordinates: {31, -91}, srid: 4326}, title: "some updated title", type: "some updated type", can_action: true}
    @invalid_attrs %{content: nil, description: nil, h3id: nil, geom: nil, title: nil, type: nil, can_action: nil}

    def entity_fixture(attrs \\ %{}) do
      {:ok, entity} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Entities.create_entity()

      entity
    end

    test "list_entities/0 returns all entities" do
      entity = entity_fixture()
      assert Entities.list_entities() == [entity]
    end

    test "get_entity!/1 returns the entity with given id" do
      entity = entity_fixture()
      assert Entities.get_entity!(entity.id) == entity
    end

    test "create_entity/1 with valid data creates a entity" do
      assert {:ok, entity} = Entities.create_entity(@valid_attrs)
      assert entity.content == %{}
      assert entity.description == "some description"
      assert entity.h3id == "some h3id"
      assert entity.geom == %Geo.Point{coordinates: {30, -90}, properties: %{}, srid: 4326}
      assert entity.title == "some title"
      assert entity.type == "some type"
    end

    test "create_entity/1 with polygon creats valid data creates a entity" do
      geom = %Geo.Polygon{
        coordinates: [
          [{35, 10}, {45, 45}, {15, 40}, {10, 20}, {35, 10}],
          [{20, 30}, {35, 35}, {30, 20}, {20, 30}]
        ],
        srid: 4326
      }
      attrs = %{content: %{}, description: "some description", h3id: "some h3id", geom: geom, title: "some title", type: "some type", can_action: false}
      assert {:ok, entity} = Entities.create_entity(attrs)
      assert entity.content == %{}
      assert entity.description == "some description"
      assert entity.h3id == "some h3id"
      assert entity.geom == geom
      assert entity.title == "some title"
      assert entity.type == "some type"
    end

    test "create_entity/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Entities.create_entity(@invalid_attrs)
    end

    test "update_entity/2 with valid data updates the entity" do
      entity = entity_fixture()
      assert {:ok, %Entity{} = entity} = Entities.update_entity(entity, @update_attrs)
      assert entity.content == %{}
      assert entity.description == "some updated description"
      assert entity.h3id == "some updated h3id"
      assert entity.geom == %Geo.Point{coordinates: {31, -91}, srid: 4326}
      assert entity.title == "some updated title"
      assert entity.type == "some updated type"
    end

    test "update_entity/2 with invalid data returns error changeset" do
      entity = entity_fixture()
      assert {:error, %Ecto.Changeset{}} = Entities.update_entity(entity, @invalid_attrs)
      assert entity == Entities.get_entity!(entity.id)
    end

    test "delete_entity/1 deletes the entity" do
      entity = entity_fixture()
      assert {:ok, %Entity{}} = Entities.delete_entity(entity)
      assert_raise Ecto.NoResultsError, fn -> Entities.get_entity!(entity.id) end
    end

    test "change_entity/1 returns a entity changeset" do
      entity = entity_fixture()
      assert %Ecto.Changeset{} = Entities.change_entity(entity)
    end
  end

  describe "relations" do
    alias Erm.Entities.Relation

    @valid_attrs %{content: %{}, title: "some title", type: "some type"}
    @update_attrs %{content: %{}, title: "some updated title", type: "some updated type"}
    @invalid_attrs %{content: nil, title: nil, type: nil}

    def relation_fixture(attrs \\ %{}) do
      {:ok, relation} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Entities.create_relation()

      relation
    end

    test "list_relations/0 returns all relations" do
      relation = relation_fixture()
      assert Entities.list_relations() == [relation]
    end

    test "get_relation!/1 returns the relation with given id" do
      relation = relation_fixture()
      assert Entities.get_relation!(relation.id) == relation
    end

    test "create_relation/1 with valid data creates a relation" do
      assert {:ok, %Relation{} = relation} = Entities.create_relation(@valid_attrs)
      assert relation.content == %{}
      assert relation.title == "some title"
      assert relation.type == "some type"
    end

    test "create_relation/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Entities.create_relation(@invalid_attrs)
    end

    test "update_relation/2 with valid data updates the relation" do
      relation = relation_fixture()
      assert {:ok, %Relation{} = relation} = Entities.update_relation(relation, @update_attrs)
      assert relation.content == %{}
      assert relation.title == "some updated title"
      assert relation.type == "some updated type"
    end

    test "update_relation/2 with invalid data returns error changeset" do
      relation = relation_fixture()
      assert {:error, %Ecto.Changeset{}} = Entities.update_relation(relation, @invalid_attrs)
      assert relation == Entities.get_relation!(relation.id)
    end

    test "delete_relation/1 deletes the relation" do
      relation = relation_fixture()
      assert {:ok, %Relation{}} = Entities.delete_relation(relation)
      assert_raise Ecto.NoResultsError, fn -> Entities.get_relation!(relation.id) end
    end

    test "change_relation/1 returns a relation changeset" do
      relation = relation_fixture()
      assert %Ecto.Changeset{} = Entities.change_relation(relation)
    end
  end
end
