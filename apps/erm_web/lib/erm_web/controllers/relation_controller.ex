defmodule ErmWeb.RelationController do
  use ErmWeb, :controller

  alias Erm.Entities
  alias Erm.Entities.Relation

  def index(conn, _params) do
    relations = Entities.list_relations()
    render(conn, "index.html", relations: relations)
  end

  def new(conn, _params) do
    changeset = Entities.change_relation(%Relation{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"relation" => relation_params}) do
    case Entities.create_relation(relation_params) do
      {:ok, relation} ->
        conn
        |> put_flash(:info, "Relation created successfully.")
        |> redirect(to: Routes.relation_path(conn, :show, relation))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    relation = Entities.get_relation!(id)
    render(conn, "show.html", relation: relation)
  end

  def edit(conn, %{"id" => id}) do
    relation = Entities.get_relation!(id)
    changeset = Entities.change_relation(relation)
    render(conn, "edit.html", relation: relation, changeset: changeset)
  end

  def update(conn, %{"id" => id, "relation" => relation_params}) do
    relation = Entities.get_relation!(id)

    case Entities.update_relation(relation, relation_params) do
      {:ok, relation} ->
        conn
        |> put_flash(:info, "Relation updated successfully.")
        |> redirect(to: Routes.relation_path(conn, :show, relation))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", relation: relation, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    relation = Entities.get_relation!(id)
    {:ok, _relation} = Entities.delete_relation(relation)

    conn
    |> put_flash(:info, "Relation deleted successfully.")
    |> redirect(to: Routes.relation_path(conn, :index))
  end
end
