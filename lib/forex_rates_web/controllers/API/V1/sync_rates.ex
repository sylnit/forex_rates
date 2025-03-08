defmodule ForexRatesWeb.API.V1.SyncRates do

  use ForexRatesWeb, :controller

  def index(conn, _params) do
    users = [
      %{id: 1, name: "Samuel Iheadindu", email: "samueliheadindu@gmail.com"},
      %{id: 1, name: "Chioma Iheadindu", email: "chummyeve@gmail.com"}
    ]
    json(conn, users)
  end
end
