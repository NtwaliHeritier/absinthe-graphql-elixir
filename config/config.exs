# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :blog,
  ecto_repos: [Blog.Repo]

# Configures the endpoint
config :blog, BlogWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "V7wuRUP7WX2XCNvXpe2RXVUVCHF7XoO7BjfEXe0G9MSD7AN3lZ+wmmvYl/ezI3Xu",
  render_errors: [view: BlogWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Blog.PubSub,
  live_view: [signing_salt: "/LYRrpbr"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :blog, Blog.Guardian,
       issuer: "blog",
       secret_key: "3XrxLh6zjAj76uxHROtQrhA/EPsf2LHAHXIGgxvwSquj+q3/VZMAKEBHqXcQFUgk"


# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
