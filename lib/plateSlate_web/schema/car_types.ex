defmodule PlateSlateWeb.Schema.CarTypes do
  use Absinthe.Schema.Notation
  alias PlateSlateWeb.Resolvers

  input_object :car_filter do
    field :name, :string
    field :color, :string
    field :company, :string
  end

  enum :sorting do
    value(:asc)
    value(:desc)
  end

  object :car do
    field :id, :id
    field :name, :string
    field :company, :string
    field :year, :string
  end

  object :car_queries do
    @desc "This list of avaliable cars"
    field :get_cars, list_of(:car) do
      arg(:filter, :car_filter, description: "Car filtering by")
      arg(:order, type: :sorting, default_value: :desc)
      resolve(&Resolvers.Cars.cars/3)
    end
  end
end
