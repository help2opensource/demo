defmodule Demo.Repo.Migrations.CreatePersons do
  use Ecto.Migration
  import Ecto.SoftDelete.Migration

  def change do
    create table(:persons) do
      add :name, :string
      add :age, :integer

      timestamps()
      soft_delete_columns()
    end
  end
end
