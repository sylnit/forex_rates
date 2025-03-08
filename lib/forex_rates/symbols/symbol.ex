defmodule ForexRates.Symbols.Symbol do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "symbols" do
    field :description, :string
    field :symbol, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(symbol, attrs) do
    symbol
    |> cast(attrs, [:symbol, :description])
    |> validate_required([:symbol, :description])
    |> unique_constraint(:symbol)
  end
end
