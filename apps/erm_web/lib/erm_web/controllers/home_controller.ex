defmodule ErmWeb.HomeController do
  use ErmWeb, :controller

  #plug Guardian.Permissions.Bitwise, [ensure: %{dashboard: [:all]}] when action in [:index]

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
