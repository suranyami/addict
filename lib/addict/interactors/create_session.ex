defmodule Addict.Interactors.CreateSession do
  import Plug.Conn

  def call(conn, user, session_type \\ :cookie) do
    create_session(session_type, conn, user)
  end

  defp create_session(:cookie, conn, user) do
    conn = conn
          |> fetch_session
          |> put_session(:current_user, Addict.Presenter.strip_all(user))
          |> assign(:current_user, Addict.Presenter.strip_all(user))
    {:ok, conn}
  end
end
