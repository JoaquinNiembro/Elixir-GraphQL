defmodule PlateSlateWeb.Schema do
  use Absinthe.Schema
  alias PlateSlateWeb.Resolvers
  import_types(__MODULE__.MenuTypes)

  scalar :date do
    parse(fn input ->
      case Date.from_iso8601(input.value) do
        {:ok, date} -> {:ok, date}
        _ -> :error
      end
    end)

    serialize(fn date -> Date.to_iso8601(date) end)
  end

  query do
    import_fields(:menu_queries)

    field :search, list_of(:search_result) do
      arg(:matching, non_null(:string))
      resolve(&Resolvers.Menu.search/3)
    end
  end
end
