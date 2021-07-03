defmodule PlateSlateWeb.Schema do
  use Absinthe.Schema
  alias PlateSlate.{Menu, Repo}

  query do
    @desc "The list of avaliable items on the menu"
    field :menu_items, list_of(:menu_item) do
      arg(:matching, :string)
      resolve &PlateSlateWeb.Resolvers.Menu.menu_items/3
    end
  end

  object :menu_item do
    @desc "item's unique identifier"
    field :id, :id
    @desc "item's name"
    field :name, :string
    @desc "item's description"
    field :description, :string
  end
end
