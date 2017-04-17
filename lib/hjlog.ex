defmodule Hjlog do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    IO.puts """
    Starting application: \x1b[33mhttp://0.0.0.0:4000\x1b[0m\
    """

    children = [
      supervisor(Hjlog.Repo, []),
      Plug.Adapters.Cowboy.child_spec(:http, Hjlog.Router, [])
    ]

    opts = [strategy: :one_for_one, name: Hjlog.Supervisor]
    Supervisor.start_link(children, opts)

  end
end
