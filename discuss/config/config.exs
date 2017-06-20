# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :discuss,
  ecto_repos: [Discuss.Repo]

# Configures the endpoint
config :discuss, Discuss.Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "PEPtVXJUqr3MX5vkS0XxELiw+s/fU/GbXcrOoa9BrDzdX237F8XRhe1qy0rMjFDQ",
  render_errors: [view: Discuss.Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Discuss.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

config :ueberauth, Ueberauth, providers: [
  github: {Ueberauth.Strategy.Github, []}
]

config :ueberauth, Ueberauth.Strategy.Github.OAuth,
  client_id: "c2892ff57b5b76184d05",
  client_secret: "7ea9932d3905d894d5987865d4b71956d3684a0c"
