defmodule Hjlog.StaticServer do
  defmacro __using__(_opts) do
    quote do
      plug Plug.Static,
        at: "/static/",
        from: Path.expand("./static")
    end
  end
end

defmodule Hjlog.Router do
  use Plug.Router

  plug Plug.Logger

  use Hjlog.StaticServer

  plug :match
  plug :dispatch

  get "/" do
    send_file(conn, 200, Path.expand("./index.html"))
  end

  match _ do
    send_resp(conn, 404, "Not found")
  end
end
