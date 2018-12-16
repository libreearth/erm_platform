# Erm

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix

* Install Ultrahook http://www.ultrahook.com
 * Run 'ultrahook erm 4000' (Only needed for Acceptance)

## ERM

Entity
: type:string
: title:string
: description:sring
: content:map
: point:geometry
: polygon:polygon
: h3id: string
: has_many: auths
: has_many: relations_to
: has_many: relations_from

Relationship
: type:string
: title:string
: permissions:string
: valid_from:date
: valid_to

: belongs_to: entity_from
: belongs_to: entity_to


screen -S caddy  sh -c "ulimit -n 65535 && exec  ./caddy --conf ./CaddyFile"

