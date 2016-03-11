defmodule Addict.Configs do
  [
    :password_strategies,
    :user_schema,
    :fn_extra_validation,
    :pre_register,
    :post_register,
    :post_login,
    :post_logout,
    :extra_validation,
    :session_type,
    :repo
  ] |> Enum.each fn key ->
         def unquote(key)() do
          Application.get_env(:addict, unquote(key))
         end
       end

end
