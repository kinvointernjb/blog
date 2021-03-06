defmodule BlogWeb.Router do
  use BlogWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", BlogWeb do
    pipe_through :api
    resources "/users", UserController, except: [:new, :edit]
    post "/users/auth", UserController, :auth
  end
end
