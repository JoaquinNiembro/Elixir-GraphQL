defmodule PlateSlate.Seeds do
  alias PlateSlate.{Menu.Item, Menu.Category, Repo, Cars.Car}

  def run_items do
    Repo.insert!(%Item{
      added_on: ~D[2000-02-28],
      description: "Roti To Eat",
      name: "Roti",
      price: Decimal.from_float(1.5),
      category_id: 1
    })

    Repo.insert!(%Item{
      added_on: ~D[2000-02-28],
      description: "Veg To Eat",
      name: "Palak Paneer",
      price: 15,
      category_id: 2
    })

    Repo.insert!(%Item{
      added_on: ~D[2000-02-28],
      description: "Tea To Drink",
      name: "Tea",
      price: Decimal.from_float(3.5),
      category_id: 1
    })
  end

  def run_categories do
    Repo.insert!(%Category{
      description: "This category includes nice toys",
      name: "Toys"
    })

    Repo.insert!(%Category{
      description: "This category includes Restaurant items",
      name: "Restaurant"
    })

    Repo.insert!(%Category{
      description: "This category includes nice videogames",
      name: "Videogames"
    })
  end

  def run_cars do
    Repo.insert!(%Car{
      company: "Masseratti",
      name: "Maseratti",
      year: "2019",
      color: "red"
    })

    Repo.insert!(%Car{
      company: "Nissan",
      name: "Tsuru",
      year: "2011",
      color: "white"
    })

    Repo.insert!(%Car{
      company: "Chevrolet",
      name: "Avalanche",
      year: "2022",
      color: "black"
    })
  end
end
