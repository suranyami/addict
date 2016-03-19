defmodule Addict.Controller do
  use Phoenix.Controller

  def register(conn, user_params) do
    result = with {:ok, user} <- Addict.Interactors.Register.call(user_params),
                  {:ok, conn} <- Addict.Interactors.CreateSession.call(conn, user),
              do: {:ok, conn, user}

    case result do
      {:ok, conn, user} -> return_success(conn, user, Addict.Configs.post_register, 201)
      {:error, errors} -> return_error(conn, errors, Addict.Configs.post_register)
    end
  end

  def login(conn, auth_params) do
    result = with {:ok, user} <- Addict.Interactors.Login.call(auth_params),
                  {:ok, conn} <- Addict.Interactors.CreateSession.call(conn, user),
              do: {:ok, conn, user}

     case result do
       {:ok, conn, user} -> return_success(conn, user, Addict.Configs.post_login)
       {:error, errors} -> return_error(conn, errors, Addict.Configs.post_login)
     end
  end

  def logout(conn, _) do
     case Addict.Interactors.DestroySession.call(conn) do
       {:ok, conn} -> return_success(conn, %{}, Addict.Configs.post_logout)
       {:error, errors} -> return_error(conn, errors, Addict.Configs.post_logout)
     end
  end

  def send_reset_pasword_link(conn, user_params) do
    email = user_params["email"]
    case Addict.Interactors.SendResetPasswordLink.call(conn, email) do
      {:ok, conn} -> return_success(conn, %{}, Addict.Configs.post_send_reset_password_link)
      {:error, errors} -> return_error(conn, errors, Addict.Configs.post_send_reset_password_link)
    end
  end

  def reset_password(conn, params) do
    case Addict.Interactors.ResetPassword.call(params) do
      {:ok, _} -> return_success(conn, %{}, Addict.Configs.post_reset_password)
      {:error, errors} -> return_error(conn, errors, Addict.Configs.post_reset_password)
    end
  end

  defp return_success(conn, user, custom_fn, status \\ 200) do
    if custom_fn == nil, do: custom_fn = fn(a,_,_) -> a end

    conn
    |> put_status(status)
    |> custom_fn.(:ok, user)
    |> json(Addict.Presenter.strip_all(user))
  end

  defp return_error(conn, errors, custom_fn) do
    if custom_fn == nil, do: custom_fn = fn (a,_,_) -> a end
    IO.puts "errors:"
    IO.inspect errors
    errors = errors |> Enum.map(fn {key, value} ->
      %{message: "#{Atom.to_string(key)} #{value}"}
    end)
    conn
    |> custom_fn.(:error, errors)
    |> put_status(400)
    |> json(%{errors: errors})
  end

end
