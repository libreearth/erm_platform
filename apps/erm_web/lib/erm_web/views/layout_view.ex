defmodule ErmWeb.LayoutView do
  use ErmWeb, :view

  def maybe_user(conn) do
    case Guardian.Plug.current_resource(conn) do
      nil ->
        false
      resource ->
        IO.inspect resource
        true
    end

  end

  def active_class(controller, conn) do

    # query_string = cond do
    #   conn.query_string == "" -> ""
    #   true -> "?#{conn.query_string}"
    # end
    # if ("#{conn.request_path}#{query_string}" === path) do "is-active" else "" end
    if(controller == Phoenix.Controller.controller_module(conn)) do
      "is-active"
    else
      ""
    end

  end
end
