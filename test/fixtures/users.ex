users model: TestAddictSchema, repo: TestAddictRepo do
  test do
    email "john.doe@example.com"
    name "John Doe"
    encrypted_password Comeonin.Pbkdf2.hashpwsalt("my passwphrase")
  end
end
