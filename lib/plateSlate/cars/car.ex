defmodule PlateSlate.Cars.Car do
  use Ecto.Schema
  import Ecto.Changeset
  alias PlateSlate.Cars.Car

  schema "cars" do
    field :name, :string
    field :company, :string
    field :year, :string
    field :color, :string

    timestamps()
  end

  def changeset(%Car{} = car, attrs) do
    car
    |> cast(attrs, [:name, :company, :year, :color])
    |> validate_required([:name, :company, :year, :color])
  end
end
