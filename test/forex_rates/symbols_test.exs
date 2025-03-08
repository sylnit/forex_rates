defmodule ForexRates.SymbolsTest do
  use ForexRates.DataCase

  alias ForexRates.Symbols

  describe "symbols" do
    alias ForexRates.Symbols.Symbol

    import ForexRates.SymbolsFixtures

    @invalid_attrs %{description: nil, symbol: nil}

    test "list_symbols/0 returns all symbols" do
      symbol = symbol_fixture()
      assert Symbols.list_symbols() == [symbol]
    end

    test "get_symbol!/1 returns the symbol with given id" do
      symbol = symbol_fixture()
      assert Symbols.get_symbol!(symbol.id) == symbol
    end

    test "create_symbol/1 with valid data creates a symbol" do
      valid_attrs = %{description: "some description", symbol: "some symbol"}

      assert {:ok, %Symbol{} = symbol} = Symbols.create_symbol(valid_attrs)
      assert symbol.description == "some description"
      assert symbol.symbol == "some symbol"
    end

    test "create_symbol/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Symbols.create_symbol(@invalid_attrs)
    end

    test "update_symbol/2 with valid data updates the symbol" do
      symbol = symbol_fixture()
      update_attrs = %{description: "some updated description", symbol: "some updated symbol"}

      assert {:ok, %Symbol{} = symbol} = Symbols.update_symbol(symbol, update_attrs)
      assert symbol.description == "some updated description"
      assert symbol.symbol == "some updated symbol"
    end

    test "update_symbol/2 with invalid data returns error changeset" do
      symbol = symbol_fixture()
      assert {:error, %Ecto.Changeset{}} = Symbols.update_symbol(symbol, @invalid_attrs)
      assert symbol == Symbols.get_symbol!(symbol.id)
    end

    test "delete_symbol/1 deletes the symbol" do
      symbol = symbol_fixture()
      assert {:ok, %Symbol{}} = Symbols.delete_symbol(symbol)
      assert_raise Ecto.NoResultsError, fn -> Symbols.get_symbol!(symbol.id) end
    end

    test "change_symbol/1 returns a symbol changeset" do
      symbol = symbol_fixture()
      assert %Ecto.Changeset{} = Symbols.change_symbol(symbol)
    end
  end
end
