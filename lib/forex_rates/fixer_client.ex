defmodule ForexRates.FixerClient do
  use GenServer

  use Tesla
  require Logger

  alias ForexRates.Symbols


  def getAccessKey() do
    GenServer.call(__MODULE__, {:get_access_key})
  end

  def sync_data() do
    #call api
    #process Response
    config = get_config()

    config
    |> client()
    # |> get_url_string()
    |> get("/latest", query: [access_key: config.access_key])
    |> case do
      {:ok, %Tesla.Env{body: response, status: 200}} ->
        Logger.info("Response from Fixer: #{inspect(response)}")
      {:ok, %Tesla.Env{status: _https_response}} = error ->
        Logger.info("Error response from Fixer: #{inspect(error)}")
    end
  end

  def get_symbols(opts = []) do
    config = get_config()

    config
    |> client()
    |> get("/symbols", query: Keyword.merge([access_key: config.access_key], opts))
    |> case do
      {:ok, %Tesla.Env{body: response, status: 200}} ->
        # Logger.info("Response from the symbols endpoint: #{inspect(response)}")
        case Symbols.insert_symbols(response) do
          {:ok, count, result} ->
            {:ok, count, result}
          _ ->
            {:error, "Data could not be inserted"}
        end
      {:ok, %Tesla.Env{status: _http_response}} = error ->
        Logger.info("Error response from Fixer: #{inspect(error)}")
    end
  end



  # Callbacks - Server Side
  def start_link(opts) do
    GenServer.start_link(
      __MODULE__,
      Map.put(opts, :access_key, System.get_env("ACCESS_KEY")),
      name: __MODULE__
    )
  end

  def init(init_arg) do
    {:ok, init_arg}
  end

  def handle_call({:get_access_key}, _from, state) do
    {:reply, %{access_key: Map.get(state, :access_key)}, state}
  end

  def get_config do
    config = Application.get_env(:forex_rates, :fixer)
    %{
      base_url: config[:base_url],
      access_key: config[:access_key]
    }
  end

  def client(config, _opts \\ []) do
    middleware = [
      {Tesla.Middleware.BaseUrl, config.base_url},
      Tesla.Middleware.JSON,
    ]

    Tesla.client(middleware)
  end

end
