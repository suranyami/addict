defmodule Addict.Crypto do
  # from http://blog.danielberkompas.com/elixir/security/2015/07/03/encrypting-data-with-ecto.html
  def sign(plaintext, key \\ Addict.Configs.secret_key) do
    :crypto.hmac(:sha512, key, plaintext) |> Base.encode16
  end

  def verify(plaintext, key \\ Addict.Configs.secret_key, signature) do
    base_signature = sign(plaintext, key)
    base_signature == signature
  end

  defp decode_key(key) do
    Base.decode64(key) |> do_decode_key
  end

  defp do_decode_key(:error) do
    {:error, ["Addict secret_key", "Addict.Configs.secret_key is invalid"]}
  end

  defp do_decode_key(key) do
    key
  end
end
