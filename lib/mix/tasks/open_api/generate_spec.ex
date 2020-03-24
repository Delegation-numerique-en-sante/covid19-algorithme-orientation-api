defmodule Mix.Tasks.Covid19Orientation.OpenApi.GenerateSpec do
  @moduledoc """
  Generate OpenAPI spec
  """

  def run([]) do
    Covid19OrientationWeb.Endpoint.start_link()

    json =
      Covid19OrientationWeb.ApiSpec.spec()
      |> Jason.encode!(pretty: true, maps: :strict)
      |> (&File.write!("openAPI.json", &1)).()
  end
end
