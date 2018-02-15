defmodule BlogWeb.Services.GateKeeper do
  import Comeonin.Bcrypt
  import Joken
  alias Blog.Accounts

  def authorize(username, password) do
    case Accounts.get_user_by_username(username) do
      user ->
        if checkpw(password, user.encrypted_password) do
          token = generate_token(user)
          {:ok, %{token: token, user: user}}
        else
          {:error, "invalid password"}
        end
      _ ->
        {:error, "No existing user"}
    end
  end

  def generate_token(user) do
    my_token =
      %{user_id: user.id}
      |> token()
      |> with_signer(hs256("my_secret"))
      |> with_iat(current_time())
      |> sign()
      |> get_compact()
  end
end
