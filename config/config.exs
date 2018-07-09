# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :RevelryKoans,
  ecto_repos: [RevelryKoans.Repo]

# Configures the endpoint
config :RevelryKoans, RevelryKoansWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "jkvhEfnUUy7YNpO65+s3jfhdz4KdJWhRYrQygw+qVdKlqTlx7kl8Ut0jFFnOXCfI",
  render_errors: [view: RevelryKoansWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: RevelryKoans.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
