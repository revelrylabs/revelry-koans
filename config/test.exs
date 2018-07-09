use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :RevelryKoans, RevelryKoansWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :RevelryKoans, RevelryKoans.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "RevelryKoans_test",
  hostname: "localhost",
  port: String.to_integer(System.get_env("PGPORT") || "5432"),
  pool: Ecto.Adapters.SQL.Sandbox
