defmodule Addict.Configs do
  [
    :secret_key,
    :password_strategies,
    :user_schema,
    :fn_extra_validation,
    :pre_register,
    :post_register,
    :post_login,
    :post_logout,
    :post_reset_password,
    :extra_validation,
    :mail_service,
    :from_email,
    :email_register_subject,
    :email_register_template,
    :reset_password_path,
    :session_type,
    :repo
  ] |> Enum.each fn key ->
         def unquote(key)() do
          Application.get_env(:addict, unquote(key))
         end
       end

end
