defmodule Covid19OrientationWeb.OrientationView do
  use Covid19OrientationWeb, :view
  alias Covid19OrientationWeb.OrientationView

  @fields [:symptomes, :pronostiques, :supplementaires, :statistiques, :conclusion]

  def render("create.json", %{orientation: orientation}) do
    %{
      data: render_one(orientation, OrientationView, "orientation.json")
    }
  end

  def render("orientation.json", %{orientation: orientation}) do
    orientation
    |> Map.take(@fields)
    |> Enum.reduce(%{}, &to_map/2)
  end

  defp to_map({key, value}, acc) do
    Map.put(acc, key, Map.from_struct(value))
  end
end
