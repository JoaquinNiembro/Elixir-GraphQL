defmodule PlateSlateWeb.Resolvers.Cars do
  alias PlateSlate.Cars

  def cars(_, args, _) do
    {:ok, Cars.list_cars(args)}
  end

  def create_car(_, %{input: params}, _) do
    case Cars.create_car(params) do
      {:error, changeset} ->
        {:ok, %{errors: transform_errors(changeset)}}

      {:ok, car} ->
        {:ok, %{car: car}}
    end
  end

  def transform_errors(changeset) do
    changeset
    |> Ecto.Changeset.traverse_errors(&format_error/1)
    |> Enum.map(fn {key, value} -> %{key: key, message: value} end)
  end

  defp format_error({msg, opts}) do
    Enum.reduce(
      opts,
      msg,
      fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", to_string(value))
      end
    )
  end
end
