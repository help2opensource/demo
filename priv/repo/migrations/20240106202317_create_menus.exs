defmodule Demo.Repo.Migrations.CreateMenus do
  use Ecto.Migration

  def change do
    create table(:menus) do
      add :name, :string
      add :code, :string
      add :category, :string

      timestamps()
    end
  end
end
