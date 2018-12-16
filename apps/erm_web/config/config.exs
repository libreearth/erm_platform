# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :erm,
  ecto_repos: [Erm.Repo]

# Configures the endpoint
config :erm, ErmWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "bzM8rb1Bb+9tPb7BInljJ+Wgi+yz66w5aU+SHw6BKHPMUcHksLG1kau7eMlRuuoz",
  render_errors: [view: ErmWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Erm.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :ueberauth, Ueberauth,
base_path: "/auth",
providers: [
  identity: {Ueberauth.Strategy.Identity, [
    callback_methods: ["POST"],
    nickname_field: :username,
    param_nesting: "user",
    uid_field: :username
  ]},
  facebook: {Ueberauth.Strategy.Facebook, [profile_fields: "name,email,about"]},
  linkedin: {Ueberauth.Strategy.LinkedIn, [default_scope: "r_basicprofile r_emailaddress"]},
  github: { Ueberauth.Strategy.Github, [default_scope: "user:email"] }
]


#Guardian
config :erm, Erm.Accounts.Guardian,
  issuer: "erm",
  secret_key: "2f4+HaGP7ti0un7UwKlha337QbNiZ/ZErbS6flWXkkWLrz0rRe5nPc8bu/VCI1M0",
  permissions: %{
    public: [
      :all
    ],
    entities: [
      :all,
      :read,
      :create,
      :update,
      :delete
    ],
    relations: [
      :all,
      :read,
      :create,
      :update,
      :delete
    ],
    entity_types: [
      :all
    ],
    relation_types: [
      :all
    ],
    map: [
      :all,
      :display,
      :action
    ],
    dashboard: [
      :all
    ]
  }




# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
