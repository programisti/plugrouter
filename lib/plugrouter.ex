defmodule Plugrouter do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    port = if System.get_env("PORT"), do: System.get_env("PORT") |> String.to_integer, else: 4000

    children = [
      Plug.Adapters.Cowboy.child_spec(:http, HTTPRouter, [], [port: port, timeout: 30000]),
    ]

    opts = [strategy: :one_for_one, name: Plugrouter.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
