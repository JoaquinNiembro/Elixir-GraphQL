defmodule PlateSlate.Repo.Migrations.CreateCars do
  use Ecto.Migration

  def change do
    create table(:cars) do
      add :name, :string, null: false
      add :company, :string
      add :year, :string
      add :color, :string

      timestamps()
    end
  end
end
