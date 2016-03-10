# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :example_app, ExampleApp.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "yfHQS4p4x6/k7h8XJ4jNC5usq8xSkeJsgiRhv/PNVFW3M/ch2XDuN8U4y1eyGW0O",
  render_errors: [accepts: ~w(html json)],
  pubsub: [name: ExampleApp.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :addict,
  fn_extra_validation: &ExampleApp.User.changeset/2,
  user_schema: ExampleApp.User,
  repo: ExampleApp.Repo,
  password_strategies: []

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# Configure phoenix generators
config :phoenix, :generators,
  migration: true,
  binary_id: false
