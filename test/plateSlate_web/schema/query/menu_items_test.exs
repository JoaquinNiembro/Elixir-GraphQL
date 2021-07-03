defmodule PlateSlateWeb.Schema.Query.MenuItemsTest do
  use PlateSlateWeb.ConnCase, async: true

  setup do
    PlateSlate.Seeds.run()
  end

  @query """
  {
  	menuItems {
  		name
  	}
  }
  """

  test "menuItems field returns menu items" do
    conn = build_conn()
    conn = get conn, "/api", query: @query

    assert json_response(conn, 200) == %{
             "data" => %{
               "menuItems" => [
                 %{"name" => "Palak Paneer"},
                 %{"name" => "Roti"},
                 %{"name" => "Tea"}
               ]
             }
           }
  end
end
