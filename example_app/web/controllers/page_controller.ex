defmodule ExampleApp.PageController do
  use ExampleApp.Web, :controller

  def index(conn, _params) do
    IO.puts "get_session"
    IO.inspect (conn |> fetch_session |> get_session(:current_user))
    IO.puts "assigns"
    IO.inspect conn.assigns[:hello]
    render conn, "index.html"
  end
end
