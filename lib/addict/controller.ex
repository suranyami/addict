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

  defp return_success(conn, user, custom_fn, status \\ 200) do
    if custom_fn == nil, do: custom_fn = fn(a,b,c) -> {b, c} end

    {user, conn} = custom_fn.(:ok, user, conn)
    conn
    |> put_status(status)
    |> json Addict.Presenter.strip_all(user)
  end

  defp return_error(conn, errors, custom_fn) do
    if custom_fn == nil, do: custom_fn = fn (a,b,c) -> {b, c} end
    IO.puts "errors:"
    IO.inspect errors
    {errors, conn} = custom_fn.(:error, errors, conn) # influenciar comportamento de output?
    errors = errors |> Enum.map(fn {key, value} ->
      %{message: "#{Atom.to_string(key)} #{value}"}
    end)
    conn
    |> put_status(400)
    |> json %{errors: errors}
  end

end
