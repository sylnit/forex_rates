defmodule ForexRatesWeb.Router do
  use ForexRatesWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ForexRatesWeb do
    pipe_through :api
  end

  # Enable Swoosh mailbox preview in development
  if Application.compile_env(:forex_rates, :dev_routes) do

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
