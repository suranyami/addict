defmodule Mix.Tasks.Addict.Generate.Configs do
  use Mix.Task

  def run(_) do
    Mix.shell.info "[o] Generating Addict configuration"
    configs_path = "./sample.exs"
    with  {:ok, file} <- File.open(configs_path, [:read, :write, :utf8]),
          data <- IO.read(file, :all),
          :ok <- add_addict_configs(file, data),
          :ok <- File.close(file),
      do: {:ok, file}
    Mix.shell.info "[o] Done!"
  end

  defp add_addict_configs(file, data) do
    secret_key = Comeonin.Bcrypt.gen_salt |> Base.encode16 |> String.downcase
    default_configs = """

    config :addict,
      secret_key: "#{secret_key}",
      user_schema: YourNamespace.User, # CHANGE THIS
      extra_validation: fn ({valid, errors}, user_params) -> {valid, errors}, # define extra validation here
      mail_service: [:mailgun],
      from_email: [no-reply@example.com],
      mailgun_domain: "example.com", # CHANGE THIS
      mailgun_key: "very-secret-indeed", # CHANGE THIS
      repo: YourNamespace.Repo, # CHANGE THIS

    config :your_app,

    """

    if String.contains?(data, "config :addict") do
      Mix.shell.error "[x] Please remove the existing Addict configuration before generating a new one"
    else
      IO.write(file, default_configs)
    end
  end
end
