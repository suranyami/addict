defmodule Addict.Mailers.MailSender do
  require Logger

  def send_register(user_params) do
    template = Addict.Configs.email_register_template || "Thanks for registering <%= email %>!"
    subject = Addict.Configs.email_register_subject || "Welcome"
    user = user_params
           |> Map.to_list
           |> Enum.reduce([], fn ({key, value}, acc) ->
             Keyword.put(acc, String.to_atom(key), value)
           end)
    html_body = EEx.eval_string(template, user)
    from_email = Addict.Configs.from_email || "no-reply@addict.github.io"
    Addict.Mailers.send_email(user_params["email"], Addict.Configs.from_email, subject, html_body)
  end

  def send_reset_token(email, path, host \\ Addict.Configs.host) do
    host = host || "http://localhost:4000"
    template = Addict.Configs.email_reset_password_template || "You've requested to reset your password. Click <a href='#{path}'>here</a> to proceed!"
    subject = Addict.Configs.email_reset_password_subject || "Reset Password"
    html_body = EEx.eval_string(template, %{email: email})
    from_email = Addict.Configs.from_email || "no-reply@addict.github.io"
    Addict.Mailers.send_email(email, Addict.Configs.from_email, subject, html_body)
  end

end
