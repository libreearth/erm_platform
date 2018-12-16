defmodule ErmWeb.AuthController do
  use ErmWeb, :controller

  #plug Ueberauth
  #alias Ueberauth.Strategy.Helpers

  alias Erm.Accounts


  plug Ueberauth

  alias Ueberauth.Strategy.Helpers

  def request(conn, _params) do
    IO.inspect Helpers.callback_url(conn)
    render(conn, "request.html", callback_url: Helpers.callback_url(conn))
  end

  def delete(conn, _params) do
    conn
    |> put_flash(:info, "You have been logged out!")
    |> configure_session(drop: true)
    |> redirect(to: "/")
  end

  def callback(%{assigns: %{ueberauth_failure: _fails}} = conn, _params) do
    conn
    |> put_flash(:error, "Failed to authentificate.")
    |> redirect(to: "/")
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    IO.puts "callback"
    IO.inspect auth

    case Accounts.authentificate_by_oauth2(auth) do
      {:ok, authentication} ->
        conn
        |> put_flash(:info, "Successfully authentificated. #{authentication.email} #{authentication.provider}")
        |> Accounts.sign_in(authentication.partner)
        |> redirect(to: "/home")
      {:error, _reason} ->
        conn
        |> put_flash(:error, "Failed to authenticate")
        #|> render("error.html")
        |> redirect(to: "/")
    end
  end

  def logout(conn, _) do
    conn
    |> Accounts.sign_out()
    |> redirect(to: "/")
  end


  # defp handle_user_conn(user, conn) do
  #   IO.puts ""
  #   case user do
  #     {:ok, user} ->
  #       # {:ok, jwt, _full_claims} =
  #       #   Erm.Guardian.encode_and_sign(user, %{})

  #       conn
  #       |> put_flash(:info, "Successfully authenticated.")
  #       |> Guardian.Plug.sign_in(user)
  #       |> redirect(to: "/")

  #     # Handle our own error to keep it generic
  #     {:error, reason} ->
  #       conn
  #       |> put_flash(:error, reason)
  #       |> redirect(to: "/")
  #   end
  # end
end

