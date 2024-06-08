defmodule App.Repo.Migrations.CreateFollows do
  use Ecto.Migration

  def change do
    create table(:follows) do
      add :follower_id, :integer
      add :following_id, :integer
      add :stop, :utc_datetime

      timestamps()
    end
  end
end
