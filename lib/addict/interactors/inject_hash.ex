defmodule Addict.Interactors.InjectHash do
  import Ecto.Query

  def call(user_params) do
    hash = Comeonin.Pbkdf2.hashpwsalt user_params["password"]
    user_params
    |> Map.drop(["password"])
    |> Map.put("encrypted_password", hash)
  end
end
