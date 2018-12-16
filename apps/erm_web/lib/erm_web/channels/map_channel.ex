defmodule ErmWeb.MapChannel do
  use Phoenix.Channel

  def join("map:lobby", _message, socket) do
    IO.puts "map socket lobby join"
    # get EI projects and send to channel
    Process.send_after(self(), :do_init, 0)
    {:ok, socket}
  end
  def join("map:" <> _private_room_id, _params, _socket) do
    {:error, %{reason: "unauthorized"}}
  end

  def handle_info(:do_init, socket) do
    IO.puts "do_init"
    #eis = ERM.Cooperation.list_farms()
    #IO.inspect eis
    #eis = ERM.Cooperation.list_e2s()
    parcels = Erm.Entities.list_parcels()
    return = ErmWeb.EntityView.render("index.json", %{entities: parcels})
    # todo return rendered html
    push socket, "entity:list", return
    IO.inspect return
    {:noreply, socket}
  end

  def handle_info(message, socket) do
    IO.puts "message"

    IO.inspect message
    #eis = ERM.Cooperation.list_e2s()
    {:noreply, socket}
  end

  def handle_in("ei:selected", %{"ei_id" => ei_id}, socket) do
    #broadcast! socket, "new_msg", %{body: body}
    IO.puts "EID selected on map: #{inspect(ei_id)}"
    # get ei data and render
    #return = ERMWeb.EIView.render("info.json", %{ei_id: ei_id})
    #ei = %{ei_id: ei_id, relations: put_relation([], "has")}
    # ei = %{ei_id: ei_id, relation: "has"}
    # #get e3 from database e3i
    # relations = []
    # farm = ERM.Cooperation.get_e2!(ei_id)
    # relations = ERM.Cooperation.list_measurements_for_farm(farm)
    # # tod put_relation(relations, relation)
    # # get ei ++ relations and render
    # html = Phoenix.View.render_to_string(ERMWeb.MapView, "e3interaction.html", ei: ei, relations: relations, farm: farm)
    # IO.inspect(html)
    # push socket, "ei:selected", %{html: html}
    {:noreply, socket}
  end

  def handle_in(message, payload, socket) do
    #broadcast! socket, "new_msg", %{body: body}
    IO.puts "new_e3 #{inspect(payload)}message: #{inspect(message)}"
    # get ei data and render
    #return = ERMWeb.EIView.render("info.json", %{ei_id: ei_id})
    #ei = %{ei_id: ei_id, relations: put_relation([], "has")}
    {:noreply, socket}
  end


end
