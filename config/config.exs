# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :covid19_orientation, Covid19OrientationWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "v0VEXqMoyB/o5vDkIEXW1/bPRK1DYFCtx7n15FHTpHn2P2CB6poIHmoNugyH9X3e",
  render_errors: [view: Covid19OrientationWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Covid19Orientation.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "l4VrGh9y"]

# Use Poison for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
