defmodule App.Repo.Migrations.CreateRepositories do
  use Ecto.Migration

  def change do
    create table(:repositories) do
      add :created_at, :string
      add :description, :string
      add :fork, :boolean, default: false, null: false
      add :forks_count, :integer
      add :full_name, :string
      add :name, :string
      add :open_issues_count, :integer
      add :owner_id, :integer
      add :pushed_at, :string
      add :stargazers_count, :integer
      add :topics, :string
      add :watchers_count, :integer

      timestamps()
    end
  end
end
