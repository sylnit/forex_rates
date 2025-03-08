defmodule ForexRates.Symbols do
  @moduledoc """
  The Symbols context.
  """

  import Ecto.Query, warn: false
  alias ForexRates.Repo

  alias ForexRates.Symbols.Symbol

  @doc """
  Returns the list of symbols.

  ## Examples

      iex> list_symbols()
      [%Symbol{}, ...]

  """
  def list_symbols do
    Repo.all(Symbol)
  end

  @doc """
  Gets a single symbol.

  Raises `Ecto.NoResultsError` if the Symbol does not exist.

  ## Examples

      iex> get_symbol!(123)
      %Symbol{}

      iex> get_symbol!(456)
      ** (Ecto.NoResultsError)

  """
  def get_symbol!(id), do: Repo.get!(Symbol, id)

  @doc """
  Creates a symbol.

  ## Examples

      iex> create_symbol(%{field: value})
      {:ok, %Symbol{}}

      iex> create_symbol(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_symbol(attrs \\ %{}) do
    %Symbol{}
    |> Symbol.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a symbol.

  ## Examples

      iex> update_symbol(symbol, %{field: new_value})
      {:ok, %Symbol{}}

      iex> update_symbol(symbol, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_symbol(%Symbol{} = symbol, attrs) do
    symbol
    |> Symbol.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a symbol.

  ## Examples

      iex> delete_symbol(symbol)
      {:ok, %Symbol{}}

      iex> delete_symbol(symbol)
      {:error, %Ecto.Changeset{}}

  """
  def delete_symbol(%Symbol{} = symbol) do
    Repo.delete(symbol)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking symbol changes.

  ## Examples

      iex> change_symbol(symbol)
      %Ecto.Changeset{data: %Symbol{}}

  """
  def change_symbol(%Symbol{} = symbol, attrs \\ %{}) do
    Symbol.changeset(symbol, attrs)
  end

  def insert_symbols( %{"success" => true, "symbols" => symbols}) do
    #loop through and insert
    timestamp = DateTime.utc_now() |> DateTime.truncate(:second)

    output = symbols
    |> Enum.map(fn {k,v} -> %{symbol: k, description: v, inserted_at: timestamp, updated_at: timestamp} end)
    # IO.inspect(output, label: "symbols output")

    # inspect(result, label: "Response from DB")

    # with {:ok, result} <- Repo.insert_all(Symbol, output, on_conflict: :nothing) do
    #   {:ok, result}
    # end

    case Repo.insert_all(Symbol, output, on_conflict: :nothing) do
      {count, result} ->
        {:ok, count, result}
      _ ->
        {:error, "Error inserting symbols into database"}
    end


  end

  def insert_symbols(_) do
    # default something.
  end

end
