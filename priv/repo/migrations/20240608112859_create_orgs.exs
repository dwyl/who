defmodule App.Repo.Migrations.CreateOrgs do
  use Ecto.Migration

  def change do
    create table(:orgs) do
      add :avatar_url, :string
      add :blog, :string
      add :company, :string
      add :created_at, :string
      add :description, :string
      add :followers, :integer
      add :location, :string
      add :login, :string
      add :name, :string
      add :public_repos, :integer

      timestamps()
    end
  end
end
