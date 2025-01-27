defmodule App.Repo.Migrations.CreateReqlogs do
  use Ecto.Migration

  def change do
    create table(:reqlogs) do
      add :req, :string
      add :param, :string

      timestamps()
    end
  end
end
