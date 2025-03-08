defmodule ForexRates.Repo.Migrations.CreateSymbols do
  use Ecto.Migration

  def change do
    create table(:symbols, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :symbol, :string
      add :description, :string

      timestamps(type: :utc_datetime)

    end

    create unique_index(:symbols, [:symbol])
  end
end
