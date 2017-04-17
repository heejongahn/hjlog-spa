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
  import Ecto.Query, only: [from: 2]
  alias Hjlog.{Repo,User}

  use Plug.Router

  plug Plug.Logger

  use Hjlog.StaticServer

  plug :match
  plug :dispatch

  get "/" do
    send_file(conn, 200, Path.expand("./index.html"))
  end

  get "/users" do
    query = from u in User,
        select: u.username

    result = Repo.all(query)
    send_resp(conn, 200, result)
  end

  match _ do
    send_resp(conn, 404, "Not found")
  end
end
