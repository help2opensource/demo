defmodule DemoWeb.Forms.SortingForm do
  import Ecto.Changeset

  alias Demo.EctoHelper

  @fields %{
    sort_by: EctoHelper.enum([:age, :name]),
    sort_dir: EctoHelper.enum([:asc, :desc])
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
