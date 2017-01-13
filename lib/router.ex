defmodule HTTPRouter do
  use Plug.Router

  plug :match
  plug :dispatch

  post "/gtwy/ndc" do
    IO.puts("HTTPRouter started...")
    conn = |> process_request
    IO.puts("HTTPRouter done!")
    conn
  end

  match _, do: send_resp(conn, 404, "Post to /gtwy/ndc")

  defp process_request(conn) do
    {:ok, body, _conn} = read_body(conn)
    case body do
      "chunked" ->
        conn = send_chunked(conn, 200)
        Enum.into(~w(each chunk as a word), conn)
        conn
      _ ->
        send_resp(conn, 200, "ordinary reponse")
    end
  end
end
