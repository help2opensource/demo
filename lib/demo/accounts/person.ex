defmodule Demo.Accounts.Person do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.SoftDelete.Schema

  schema "persons" do
    field :name, :string
    field :age, :integer

    timestamps()
    soft_delete_schema()
  end

  @doc false
  def changeset(person, attrs) do
    person
    |> cast(attrs, [:name, :age])
    |> validate_required([:name, :age])
  end
end
