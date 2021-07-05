defmodule PlateSlate.Cars do
  import Ecto.Query, warn: false
  alias PlateSlate.Repo
  alias PlateSlate.Cars.Car

  def list_cars(args) do
    args
    |> Enum.reduce(
      Car,
      fn
        {:order, order}, query ->
          query
          |> order_by({^order, :name})

        {:filter, filter}, query ->
          query
          |> filter_cars_by(filter)
      end
    )
    |> Repo.all()
  end

  defp filter_cars_by(query, filter) do
    Enum.reduce(filter, query, fn
      {:name, name}, query ->
        from car in query, where: ilike(car.name, ^"%#{name}")

      {:color, color}, query ->
        from car in query, where: ilike(car.color, ^"%#{color}")

      {:company, company}, query ->
        from car in query, where: ilike(car.company, ^"%#{company}")
    end)
  end
end
