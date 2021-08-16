# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :tradelab_assignment,
  ecto_repos: [TradelabAssignment.Repo]

# Configures the endpoint
config :tradelab_assignment, TradelabAssignmentWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "pUeaXJ1k/AX1EtMz94FIuriYPYp4Z76bcfiSRLpUmAYmN5tBpgiuWUjNa7l4eEWE",
  render_errors: [view: TradelabAssignmentWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: TradelabAssignment.PubSub,
  live_view: [signing_salt: "zNFX6F8k"],
  symbols: ["ETHBTC", "BTCUSDT"],
  crypto_base_url: "https://api.hitbtc.com/api/3/public/ticker/"

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
