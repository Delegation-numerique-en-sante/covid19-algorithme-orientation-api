defmodule Covid19QuestionnaireWeb.Router do
  use Covid19QuestionnaireWeb, :router
  alias Covid19QuestionnaireWeb.ApiSpec
  alias OpenApiSpex.Plug.{PutApiSpec, RenderSpec, SwaggerUI}

  pipeline :api do
    plug :accepts, ["json"]
    plug PutApiSpec, module: ApiSpec
  end

  pipeline :browser do
    plug :accepts, ["html"]
  end

  scope "/", Covid19QuestionnaireWeb do
    pipe_through :api

    get "/", BienvenueController, :index
    post "/token", TokenController, :create
    post "/questionnaire", QuestionnaireController, :create
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
