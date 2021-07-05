defmodule PlateSlateWeb.Resolvers.Cars do
  alias PlateSlate.Cars

  def cars(_, args, _) do
    {:ok, Cars.list_cars(args)}
  end
end
