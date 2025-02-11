defmodule ForexRates.FixerClient do
  use GenServer

  def getAccessKey() do
    GenServer.call(__MODULE__, {:get_access_key})
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

end
