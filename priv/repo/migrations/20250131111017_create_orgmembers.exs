defmodule App.Repo.Migrations.CreateOrgmembers do
  use Ecto.Migration

  def change do
    create table(:orgmembers) do
      add :org_id, :integer, primary_key: true
      add :user_id, :integer, primary_key: true
      add :stop, :utc_datetime

      timestamps()
    end

    # https://stackoverflow.com/questions/36418223/unique-constraint-two-columns
    create unique_index(:orgmembers, [:org_id, :user_id], name: :orgmembers_unique)
  end
end
