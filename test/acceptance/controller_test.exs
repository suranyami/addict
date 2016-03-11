defmodule ControllerTest do
  use ExUnit.Case, async: false
  use Addict.RepoSetup
  use Plug.Test
  import Addict.SessionSetup, only: [with_session: 1]

  @opts TestAddictRouter.init([])

  test "it creates a user" do
    Application.put_env(:addict, :user_schema, TestAddictSchema)
    Application.put_env(:addict, :repo, TestAddictRepo)

    request_params = %{
      "name" => "John Doe",
      "email" => "john.doe@example.com",
      "password" => "my password"
    }

    conn = with_session conn(:post, "/register", request_params)
    conn = TestAddictRouter.call(conn, @opts)

    user = conn |> Plug.Conn.get_session(:current_user)
    assert conn.status == 201
    assert user[:email] == "john.doe@example.com"
  end

  test "it logs in a user" do
    Application.put_env(:addict, :user_schema, TestAddictSchema)
    Application.put_env(:addict, :repo, TestAddictRepo)

    request_params = %{
      "email" => "john.doe@example.com",
      "password" => "my passphrase"
    }

    Addict.Interactors.Register.call(request_params)

    conn = conn(:post, "/login", request_params)
           |> with_session
           |> TestAddictRouter.call(@opts)

    user = conn |> Plug.Conn.get_session(:current_user)

    assert conn.status == 200
    assert user[:email] == "john.doe@example.com"

  end

  test "it logs out a user" do
    Application.put_env(:addict, :user_schema, TestAddictSchema)
    Application.put_env(:addict, :repo, TestAddictRepo)

    conn = conn(:post, "/logout", nil)
           |> with_session
           |> Plug.Conn.put_session(:current_user, %{email: "john.doe@example.com"})
           |> TestAddictRouter.call(@opts)

    user = conn |> Plug.Conn.get_session(:current_user)

    assert conn.status == 200
    assert user == nil
  end
end
