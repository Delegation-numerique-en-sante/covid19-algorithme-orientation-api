defmodule Mix.Tasks.Covid19Orientation.OpenApi3.GenSpec do
  @moduledoc """
  Generates the OpenAPI 3.0 spec.
  """

  def run([]) do
    Covid19OrientationWeb.Endpoint.start_link()

    Covid19OrientationWeb.ApiSpec.spec()
    |> Jason.encode!(pretty: true, maps: :strict)
    |> (&File.write!("openapi3.json", &1)).()
  end
end
