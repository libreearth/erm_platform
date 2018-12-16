defmodule ErmWeb.EntityController do
  use ErmWeb, :controller

  alias Erm.Entities
  alias Erm.Entities.Entity

  plug Guardian.Permissions.Bitwise, [ensure: %{entities: [:all]}]

  def index(conn, _params) do
    entities = Entities.list_entities()
    render(conn, "index.html", entities: entities)
  end

  def new(conn, _params) do
    changeset = Entities.change_entity(%Entity{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"entity" => entity_params}) do
    IO.puts "create"
    IO.inspect entity_params
    IO.puts "create"
    case Entities.create_entity(entity_params) do
      {:ok, entity} ->
        conn
        |> put_flash(:info, "Entity created successfully.")
        |> redirect(to: Routes.entity_path(conn, :show, entity))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    entity = Entities.get_entity!(id)
    render(conn, "show.html", entity: entity)
  end

  def edit(conn, %{"id" => id}) do
    entity = Entities.get_entity!(id)
    changeset = Entities.change_entity(entity)
    render(conn, "edit.html", entity: entity, changeset: changeset)
  end

  def update(conn, %{"id" => id, "entity" => entity_params}) do
    entity = Entities.get_entity!(id)

    case Entities.update_entity(entity, entity_params) do
      {:ok, entity} ->
        conn
        |> put_flash(:info, "Entity updated successfully.")
        |> redirect(to: Routes.entity_path(conn, :show, entity))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", entity: entity, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    entity = Entities.get_entity!(id)
    {:ok, _entity} = Entities.delete_entity(entity)

    conn
    |> put_flash(:info, "Entity deleted successfully.")
    |> redirect(to: Routes.entity_path(conn, :index))
  end
end
