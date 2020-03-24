defmodule Covid19OrientationWeb.Router do
  use Covid19OrientationWeb, :router
  alias Covid19OrientationWeb.ApiSpec
  alias OpenApiSpex.Plug.{PutApiSpec, RenderSpec, SwaggerUI}

  pipeline :api do
    plug :accepts, ["json"]
    plug PutApiSpec, module: ApiSpec
  end

  pipeline :browser do
    plug :accepts, ["html"]
  end

  scope "/", Covid19OrientationWeb do
    pipe_through :api

    get "/", BienvenueController, :index
    post "/orientation", OrientationController, :create
  end

  scope "/" do
    pipe_through :api

    get "/openapi", RenderSpec, :show
  end

  scope "/" do
    pipe_through :browser

    get "/swagger", SwaggerUI, path: "/openapi"
  end
end
