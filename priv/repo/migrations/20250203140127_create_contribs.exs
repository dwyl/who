defmodule App.Repo.Migrations.CreateContribs do
  use Ecto.Migration

  def change do
    create table(:contribs) do
      add :repo_id, :integer, primary_key: true
      add :user_id, :integer, primary_key: true
      add :count, :integer

      timestamps()
    end

    # https://stackoverflow.com/questions/36418223/unique-constraint-two-columns
    create unique_index(:contribs, [:repo_id, :user_id], name: :contribs_unique)
  end
end
