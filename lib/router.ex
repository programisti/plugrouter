defmodule HTTPRouter do
  use Plug.Router

  plug :match
  plug :dispatch

  post "/gtwy/ndc" do
    IO.puts("HTTPRouter started...")
    conn = conn |> process_request
    IO.puts("HTTPRouter done!")
    conn
  end

  match _, do: send_resp(conn, 404, "Post to /gtwy/ndc")

  defp process_request(conn) do
    IO.inspect "procesing request"
    case read_body(conn) do
      {:ok, "chunked", _conn} ->
        IO.inspect "chunked"
        conn = send_chunked(conn, 200)
        Enum.into(~w(each chunk as a word), conn)
        conn
      _ ->
        IO.inspect "ordinary"
        send_resp(conn, 200, "ordinary reponse")
    end
  end
end
