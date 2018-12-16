defmodule Erm.Entities.Entity do
  use Ecto.Schema
  import Ecto.Changeset


  schema "entities" do
    field :content, :map
    field :description, :string
    field :h3id, :string
    field :geom, Geo.PostGIS.Geometry
    field :title, :string
    field :type, :string
    field :status, :string
    field :can_action, :boolean
    field :date_from, :utc_datetime
    field :date_to, :utc_datetime

    has_many :auths, Erm.Accounts.Authentification, foreign_key: :partner_id,
    on_delete: :delete_all

    has_many :roles, Erm.Authorizations.Role, foreign_key: :entity_id,
    on_delete: :delete_all

    has_many :relations_to, Erm.Entities.
    Relation, foreign_key: :entity_from_id,
    on_delete: :delete_all

    has_many :relations_from, Erm.Entities.
    Relation, foreign_key: :entity_to_id,
    on_delete: :delete_all


    timestamps()
  end

  @doc false
  def changeset(entity, attrs) do
    entity
    |> cast(attrs, [:type, :title, :description, :h3id, :can_action, :date_from, :date_to, :status])
    |> cast_geometry(attrs)
    |> cast_content(attrs)
    |> cast_geojson(attrs)
    |> validate_required([:type, :title])
  end

  defp cast_geojson(changeset, %{"geojson" => ""}) do
    changeset
  end

  defp cast_geojson(changeset, %{"geojson" => geojson}) do
    geojson
    |> Jason.decode!()
    |> Geo.JSON.decode()
    |> case do
      {:ok, geom} ->
        put_change(changeset, :geom, geom)
      {:error, _error} ->
        changeset
    end
  end

  defp cast_geojson(changeset, _attrs) do
    changeset
  end

  def cast_content(changeset, %{"content" => content}) do
    put_change(changeset, :content, content)
  end

  def cast_content(changeset, _attrs) do
    changeset
  end

  defp cast_geometry(changeset, %{"geom" => %{"0" => %{"lat" => "", "long" => ""}}}) do
    changeset
  end

  defp cast_geometry(changeset, attrs) do
    geom = attrs["geom"]

    geom = if(geom != nil) do
      Enum.reduce(geom, [], fn({_k, v}, acc) ->
        acc ++ [cast_point(v)]
      end)
    end
    IO.puts "cast geom"
    IO.inspect geom


    changeset
    |> cast_geo(geom)
  end

  defp cast_point(%{"lat" => lat, "long" => long}) do
    {lat, ""} = Float.parse(lat)
    {long, ""} = Float.parse(long)
    {lat, long}
  end

  defp cast_geo(changeset, [point]) do
    point = %Geo.Point{coordinates: point, properties: %{}, srid: 4326}
    put_change(changeset, :geom, point)
  end

  defp cast_geo(changeset, [_point1|[_point2]] = geom) do
    line = %Geo.LineString{srid: 4326, coordinates: geom}
    put_change(changeset, :geom, line)
  end

  defp cast_geo(changeset, [_point1|_rest] = geom) do
    IO.puts "cast polygon"
    polygon = %Geo.LineString{srid: 4326, coordinates: geom}
    #TODO need to read about polygons, how are they really built, howe money points are needed
    # p = %Geo.Polygon{
    #   coordinates: [
    #     [{35, 10}, {45, 45}, {15, 40}, {10, 20}, {35, 10}],
    #     [{20, 30}, {35, 35}, {30, 20}, {20, 30}]
    #   ],
    #   srid: 4326
    # }
    put_change(changeset, :geom, polygon)
  end

  defp cast_geo(changeset, _) do
    changeset
  end


end
