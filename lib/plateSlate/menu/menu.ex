defmodule PlateSlate.Menu.Menu do
  alias PlateSlate.{Menu, Repo, Menu.Item}
  import Ecto.Query

  def create_item(attrs \\ %{}) do
    %Item{}
    |> Item.changeset(attrs)
    |> Repo.insert()
  end

  def list_items(args) do
    args
    |> Enum.reduce(
      Menu.Item,
      fn
        {:order, order}, query ->
          query
          |> order_by({^order, :name})

        {:filter, filter}, query ->
          query
          |> filter_with(filter)
      end
    )
    |> Repo.all()
  end

  def list_items(_) do
    Repo.all(Menu.Item)
  end

  defp filter_with(query, filter) do
    IO.inspect(query)

    Enum.reduce(filter, query, fn
      {:name, name}, query ->
        from q in query, where: ilike(q.name, ^"%#{name}")

      {:priced_above, price}, query ->
        from q in query, where: q.price >= ^price

      {:priced_below, price}, query ->
        from q in query, where: q.price <= ^price

      {:category, category_name}, query ->
        from q in query,
          join: c in assoc(q, :category),
          where: ilike(c.name, ^"%#{category_name}")

      {:tag, tag_name}, query ->
        from q in query,
          join: t in assoc(q, :tags),
          where: ilike(t.name, ^"%#{tag_name}%")

      {:added_after, date}, query ->
        from q in query, where: q.added_on >= ^date

      {:added_before, date}, query ->
        from q in query, where: q.added_on <= ^date
    end)
  end

  # def list_items(filters) do
  # filters
  # |> Enum.reduce(
  # Menu.Item,
  # fn
  # {_, nil}, query -> query
  # {:order, order}, query -> from q in query, order_by: {^order, :name}
  # {:matching, name}, query -> from q in query, where: ilike(q.name, ^"%#{name}")
  # end
  # )
  # |> Repo.all()
  # end

  @search [Menu.Item, Menu.Category]
  def search(term) do
    pattern = "%#{term}"

    Enum.flat_map(@search, &search_ecto(&1, pattern))
  end

  defp search_ecto(ecto_schema, pattern) do
    Repo.all(
      from q in ecto_schema, where: ilike(q.name, ^pattern) or ilike(q.description, ^pattern)
    )
  end
end
