defmodule PlateSlateWeb.Schema do
  use Absinthe.Schema
  alias PlateSlateWeb.Resolvers
  import_types(__MODULE__.{MenuTypes, CarTypes})

  scalar :date do
    parse(fn input ->
      case Date.from_iso8601(input.value) do
        {:ok, date} -> {:ok, date}
        _ -> :error
      end
    end)

    serialize(fn date -> Date.to_iso8601(date) end)
  end

  scalar :decimal do
    parse(fn
      %{value: value}, _ ->
        Decimal.from_float(value)

      _, _ ->
        :error
    end)

    serialize(&to_string/1)
  end

  query do
    import_fields(:menu_queries)
    import_fields(:car_queries)

    field :search, list_of(:search_result) do
      arg(:matching, non_null(:string))
      resolve(&Resolvers.Menu.search/3)
    end
  end

  input_object :menu_item_input do
    field :name, non_null(:string)
    field :description, :string
    field :price, :decimal
    field :category_id, non_null(:id)
  end

  input_object :car_input do
    field :name, non_null(:string)
    field :company, non_null(:string)
    field :year, :string
  end

  mutation do
    field :create_menu_item, :menu_item do
      arg(:input, non_null(:menu_item_input))
      resolve(&Resolvers.Menu.create_item/3)
    end

    field :create_car, :car do
      arg(:input, non_null(:car_input))
      resolve(&Resolvers.Cars.create_car/3)
    end
  end
end
