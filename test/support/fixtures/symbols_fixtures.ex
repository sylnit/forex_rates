defmodule ForexRates.SymbolsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ForexRates.Symbols` context.
  """

  @doc """
  Generate a symbol.
  """
  def symbol_fixture(attrs \\ %{}) do
    {:ok, symbol} =
      attrs
      |> Enum.into(%{
        description: "some description",
        symbol: "some symbol"
      })
      |> ForexRates.Symbols.create_symbol()

    symbol
  end
end
