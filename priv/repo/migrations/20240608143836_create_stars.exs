defmodule App.Repo.Migrations.CreateStars do
  use Ecto.Migration

  def change do
    create table(:stars) do
      add :repo_id, :integer
      add :user_id, :integer
      add :stop, :utc_datetime, default: nil

      timestamps()
    end
  end
end
