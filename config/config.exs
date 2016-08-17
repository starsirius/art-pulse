# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :pulse, Pulse.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Sgfd0kT0XYS2bqQRPe4r3osW7ODFQmQ+PC6l1mCslXC1k4ncP42YLX7cVS9U8tBO",
  render_errors: [view: Pulse.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Pulse.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# Configure ExTwitter
config :extwitter, :oauth, [
   consumer_key: System.get_env("TWITTER_CONSUMER_KEY"),
   consumer_secret: System.get_env("TWITTER_CONSUMER_SECRET"),
   access_token: System.get_env("TWITTER_ACCESS_TOKEN"),
   access_token_secret: System.get_env("TWITTER_ACCESS_TOKEN_SECRET")
]
