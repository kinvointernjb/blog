defmodule BlogWeb.UserView do
  use BlogWeb, :view
  alias BlogWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("show_with_token.json", user_with_token) do
    %{data: render_one(user_with_token, UserView, "user_with_token.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      username: user.username}
  end

  def render("user_with_token.json", %{user: %{user: user, token: token}}) do
    %{id: user.id,
      username: user.username,
      meta: %{
        token: token
      }
    }
  end
end
