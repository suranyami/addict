defmodule Addict.Helper do
  defmacro __using__() do
    quote do
      import Addict.Helper
    end
  end

  def current_user(conn) do
    conn |> Plug.Conn.fetch_session |> Plug.Conn.get_session(:current_user)
  end
end
