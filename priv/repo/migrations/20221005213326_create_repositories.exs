defmodule App.Repo.Migrations.CreateRepositories do
  use Ecto.Migration

  def change do
    create table(:repositories) do
      add :name, :string
      add :full_name, :string
      add :owner_id, :integer
      add :description, :string
      add :fork, :boolean, default: false, null: false
      add :forks_count, :integer
      add :watchers_count, :integer
      add :stargazers_count, :integer
      add :topics, :string
      add :open_issues_count, :integer
      add :created_at, :string
      add :pushed_at, :string

      timestamps()
    end
  end
end
