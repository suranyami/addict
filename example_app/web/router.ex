defmodule ExampleApp.Router do
  use ExampleApp.Web, :router
  use Addict.RoutesHelper

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    # plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :addict_api do
    plug :accepts, ["json"]
  end

  scope "/" do
    pipe_through :browser # Use the default browser stack
    get "/", ExampleApp.PageController, :index
    addict :routes
  end


  # Other scopes may use custom stacks.
  # scope "/api", ExampleApp do
  #   pipe_through :api
  # end
end
