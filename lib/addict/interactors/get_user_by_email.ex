defmodule Addict.Interactors.GetUserByEmail do
  def call(email, schema \\ Addict.Configs.user_schema, repo \\ Addict.Configs.repo) do
    repo.get_by(schema, email: email) |> process_response
  end

  defp process_response(nil) do
    {:error, [email: "Incorrect e-mail"]}
  end

  defp process_response(user) do
    {:ok, user}
  end

end
