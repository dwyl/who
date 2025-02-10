defmodule App.Repo.Migrations.CreateFollows do
  use Ecto.Migration

  def change do
    create table(:follows) do
      add :follower_id, :integer, primary_key: true
      add :following_id, :integer, primary_key: true
      add :stop, :utc_datetime
      add :is_org, :boolean, default: false

      timestamps()
    end

    # https://stackoverflow.com/questions/36418223/unique-constraint-two-columns
    create unique_index(:follows, [:follower_id, :following_id],
      name: :follows_unique)
  end
end
