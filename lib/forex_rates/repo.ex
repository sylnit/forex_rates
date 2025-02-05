defmodule ForexRates.Repo do
  use Ecto.Repo,
    otp_app: :forex_rates,
    adapter: Ecto.Adapters.Postgres
end
