defmodule Blog.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  import Comeonin.Bcrypt
  alias Blog.Accounts.User

  schema "users" do
    field :encrypted_password, :string
    field :username, :string
    field :password, :string, virtual: true

    timestamps()
  end

  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:username, :password])
    |> validate_required([:username, :password])
    |> encrypt_password()
  end

  defp encrypt_password(%Ecto.Changeset{valid?: true, changes:
    %{password: password}} = changeset) do

    change(changeset, add_hash(password, hash_key: :encrypted_password))
  end

  defp encrypt_password(changeset), do: changeset
end
