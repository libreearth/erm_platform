defmodule ErmWeb.AuthentificationController do
  use ErmWeb, :controller

  alias Erm.Accounts
  alias Erm.Accounts.Authentification

  def index(conn, _params) do
    authentifications = Accounts.list_authentifications()
    render(conn, "index.html", authentifications: authentifications)
  end

  def new(conn, _params) do
    changeset = Accounts.change_authentification(%Authentification{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"authentification" => authentification_params}) do
    case Accounts.create_authentification(authentification_params) do
      {:ok, authentification} ->
        conn
        |> put_flash(:info, "Authentification created successfully.")
        |> redirect(to: Routes.authentification_path(conn, :show, authentification))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    authentification = Accounts.get_authentification!(id)
    render(conn, "show.html", authentification: authentification)
  end

  def edit(conn, %{"id" => id}) do
    authentification = Accounts.get_authentification!(id)
    changeset = Accounts.change_authentification(authentification)
    render(conn, "edit.html", authentification: authentification, changeset: changeset)
  end

  def update(conn, %{"id" => id, "authentification" => authentification_params}) do
    authentification = Accounts.get_authentification!(id)

    case Accounts.update_authentification(authentification, authentification_params) do
      {:ok, authentification} ->
        conn
        |> put_flash(:info, "Authentification updated successfully.")
        |> redirect(to: Routes.authentification_path(conn, :show, authentification))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", authentification: authentification, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    authentification = Accounts.get_authentification!(id)
    {:ok, _authentification} = Accounts.delete_authentification(authentification)

    conn
    |> put_flash(:info, "Authentification deleted successfully.")
    |> redirect(to: Routes.authentification_path(conn, :index))
  end
end
