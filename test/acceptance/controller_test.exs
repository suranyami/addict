defmodule ControllerTest do
  import Addict.SessionSetup, only: [with_session: 1]
  use Addict.RepoSetup
  use ExUnit.Case, async: false
  use Plug.Test

  @opts TestAddictRouter.init([])

  test "it creates a user" do
    Application.put_env(:addict, :user_schema, TestAddictSchema)
    Application.put_env(:addict, :repo, TestAddictRepo)

    conn = with_session conn(:post, "/register", %{
      name: "John Doe",
      email: "john.doe@example.com",
      password: "my password"
    })
    conn = TestAddictRouter.call(conn, @opts)
    assert conn.status == 201
  end
end
