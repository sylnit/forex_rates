defmodule ForexRates.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ForexRatesWeb.Telemetry,
      ForexRates.Repo,
      {DNSCluster, query: Application.get_env(:forex_rates, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: ForexRates.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: ForexRates.Finch},
      # Start a worker by calling: ForexRates.Worker.start_link(arg)
      # {ForexRates.Worker, arg},
      # Start to serve requests, typically the last entry
      {ForexRates.FixerClient, %{}},
      ForexRatesWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ForexRates.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ForexRatesWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
