defmodule Hjlog do
  use Application

  def start(_type, _args) do
    IO.puts """
    Starting application: \x1b[33mhttp://0.0.0.0:4000\x1b[0m\
    """

    Plug.Adapters.Cowboy.http(Hjlog.Router, [])
  end
end
