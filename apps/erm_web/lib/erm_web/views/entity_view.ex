defmodule ErmWeb.EntityView do
  use ErmWeb, :view

  def to_geo_display(geom) do
    to_string(geom)
  end

  def to_safe_content(content) do
    Jason.encode!(content)
  end

  def render("index.json", %{entities: entities}) do
    %{data: render_many(entities, ErmWeb.EntityView, "entity.json")}
  end

  def render("show.json", %{entity: entity}) do
    %{data: render_one(entity, ErmWeb.EntityView, "entity.json")}
  end

  def render("entity.json", %{entity: entity}) do
    # {lat, long} = if(ei.geom) do
    #   ei.geom.coordinates
    # else
    #   {nil, nil}
    # end
    geom = if(entity.geom) do
      Geo.JSON.encode!(entity.geom)
    else
      nil
    end
    %{id: entity.id, description: entity.description, geom: geom}
  end

  # def render("info.json", %{ei_id: ei_id}) do
  #   ei = ERM.Cooperation.get_e2!(ei_id)
  #   %{data: render_one(ei, ERMWeb.EIView, "ei.json")}
  # end

  # def get_parent_lat_lon(%Geo.Point{coordinates: {lat, lon}}) do
  #   {lat, lon}
  # end

  def to_lat({lat, _lon}), do: lat
  def to_lon({_lat, lon}), do: lon
end
