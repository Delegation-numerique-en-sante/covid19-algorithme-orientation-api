defmodule Covid19Questionnaire.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Start the endpoint when the application starts
      Covid19QuestionnaireWeb.Endpoint,
      Covid19Questionnaire.Data.Repo,
      Covid19Questionnaire.Data.Store,
      Covid19Questionnaire.Scheduler,
      # Starts a worker by calling: Covid19Questionnaire.Worker.start_link(arg)
      # {Covid19Questionnaire.Worker, arg},
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    Covid19QuestionnaireWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
