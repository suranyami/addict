defmodule Addict.Interactors.SendResetPasswordEmail do
  alias Addict.Interactors.{GetUserByEmail}

  def call(%{"email" => email}, configs \\ Addict.Configs) do
    with {:ok, user} <- Addict.Interactors.GetUserByEmail.call(email),
         {:ok, path} <- Addict.Interactors.GeneratePasswordResetLink.call(user.id, configs.secret_key),
         {:ok, _} <- Addict.Mailers.MailSender.send_reset_token(email, path),
     do: {:ok, user}
  end
end
