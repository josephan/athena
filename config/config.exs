# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :athena,
  ecto_repos: [Athena.Repo]

# Configures the endpoint
config :athena, AthenaWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "3/xRrXguEdia6VUFXqMNid9V+7LkXek6r6z0uRV1hkulkZXjAEJlc5nkw4m+Sd+G",
  render_errors: [view: AthenaWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Athena.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
