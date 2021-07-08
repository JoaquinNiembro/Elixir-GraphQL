defmodule PlateSlateWeb.Schema.MenuTypes do
  use Absinthe.Schema.Notation
  alias PlateSlateWeb.Resolvers

  object :category do
    interfaces([:search_result])
    field :name, :string
    field :description, :string

    field :items, list_of(:menu_item) do
      resolve(&Resolvers.Menu.items_for_category/3)
    end
  end

  @desc "Filtering options for the menu item list"
  input_object :menu_item_filter do
    @desc "Matching a name"
    field :name, :string
    @desc "Matching a category name"
    field :category, :string
    @desc "Matching a tag"
    field :tag, :string
    @desc "Priced above a value"
    field :priced_above, :float
    @desc "Priced below a value"
    field :priced_below, :float
    @desc "Added to the menu before this date"
    field :added_before, :date
    @desc "Added tot he menu after this date"
    field :added_after, :date
  end

  object :menu_item do
    interfaces([:search_result])
    @desc "item's unique identifier"
    field :id, :id
    @desc "item's name"
    field :name, :string
    @desc "item's description"
    field :description, :string
    @desc "item's date of creation"
    field :added_on, :date
    @desc "item's price"
    field :price, :decimal
  end

  object :menu_item_result do
    field :menu_item, :menu_item
    field :errors, list_of(:input_error)
  end

  @desc "An error encountered trying to persist input"
  object :input_error do
    field :key, non_null(:string)
    field :message, non_null(:string)
  end

  enum :sort_order do
    value(:asc)
    value(:desc)
  end

  object :menu_queries do
    @desc "The list of avaliable items on the menu"
    field :menu_items, list_of(:menu_item) do
      # arg, {name}, {type}
      arg(:filter, non_null(:menu_item_filter))
      arg(:order, type: :sort_order, default_value: :asc)
      resolve(&Resolvers.Menu.menu_items/3)
    end

    field :search, list_of(:search_result) do
      arg(:matching, non_null(:string))
      resolve(&Resolvers.Menu.search/3)
    end
  end

  interface :search_result do
    field :name, :string

    resolve_type(fn
      %PlateSlate.Menu.Item{}, _ -> :menu_item
      %PlateSlate.Menu.Category{}, _ -> :category
      _, _ -> nil
    end)
  end
end
