defmodule Demo.Repo.Migrations.CreateMenuss do
  use Ecto.Migration

  def change do
    create table(:menuss) do
      add :name, :string
      add :code, :string
      add :category, :string

      timestamps()
    end
  end
end
