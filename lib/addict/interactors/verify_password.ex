defmodule Addict.Interactors.VerifyPassword do
  import Ecto.Query

  def call(user, %{"password" => password}) do
    Comeonin.Pbkdf2.checkpw(password, user.encrypted_password) |> process_response
  end

  defp process_response(false) do
    {:error, [password: "Incorrect password"]}
  end

  defp process_response(true) do
    {:ok}
  end


end
