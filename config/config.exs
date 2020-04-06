# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configure the app
config :covid19_questionnaire,
  documentation_url:
    "https://github.com/Delegation-numerique-en-sante/covid19-algorithme-orientation",
  issue_url:
    "please open an issue https://github.com/Delegation-numerique-en-sante/covid19-algorithme-orientation-api/issues/new"

# Configures the endpoint
config :covid19_questionnaire, Covid19QuestionnaireWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "v0VEXqMoyB/o5vDkIEXW1/bPRK1DYFCtx7n15FHTpHn2P2CB6poIHmoNugyH9X3e",
  render_errors: [view: Covid19QuestionnaireWeb.ErrorView, accepts: ~w(json)]

# Use Poison for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :covid19_questionnaire, ecto_repos: [Covid19Questionnaire.Data.Repo]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
