defmodule Addict.Interactors.Register do
  alias Addict.Interactors.{ValidateUserForRegistration, InsertUser, InjectHash}
  @user Application.get_env(:addict, :user_schema)
  @db Application.get_env(:addict, :repo)

  def call(user_params, configs \\ Addict.Configs) do
    fn_extra_validation = configs.fn_extra_validation || fn (a,b) -> a end

    {valid, errors} = ValidateUserForRegistration.call(user_params)
    user_params = InjectHash.call user_params
    {valid, errors} = fn_extra_validation.({valid, errors}, user_params)

    case {valid, errors} do
       {:ok, _} -> insert_user(user_params, configs)
       {:error, errors} -> {:error, errors}
    end

  end

  defp insert_user(user_params, configs) do
    Addict.Interactors.InsertUser.call(configs.user_schema, user_params, configs.repo)
  end
end
