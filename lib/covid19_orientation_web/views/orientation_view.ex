defmodule Covid19OrientationWeb.OrientationView do
  use Covid19OrientationWeb, :view
  alias Covid19OrientationWeb.OrientationView

  def render("create.json", %{orientation: orientation}) do
    %{
      data: render_one(orientation, OrientationView, "orientation.json")
    }
  end

  def render("orientation.json", %{orientation: orientation}), do: orientation
end
