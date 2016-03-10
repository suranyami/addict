defmodule InjectHashTest do
  # alias Addict.Interactors.InjectHash
  use ExUnit.Case, async: true

  test "it validates the default use case" do
    # changeset = %TestAddictUser{} |> Ecto.Changeset.cast(%{password: "123"}, ~w(password),[])
    # %Ecto.Changeset{errors: errors, valid?: valid} = ValidatePassword.call(changeset, [])
    # assert errors == [password: "is too short"]
    # assert valid == false
  end
end
