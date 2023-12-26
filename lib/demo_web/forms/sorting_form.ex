defmodule DemoWeb.Forms.SortingForm do
  import Ecto.Changeset

  @fields %{
    sort_by: Ecto.Enum, values: [:age, :name],
    sort_dir: Ecto.Enum, values: [:asc, :desc]
  }

  @fields %{
    id: :integer,
    name: :string
  }

  @default_values %{
    sort_by: :name,
    sort_dir: :asc
  }

  def parse(params) do
    {@default_values, @fields}
    |> cast(params, Map.keys(@fields))
    |> apply_action(:insert)
  end

  def default_values(overrides \\ %{}), do: Map.merge(@default_values, overrides)
end
