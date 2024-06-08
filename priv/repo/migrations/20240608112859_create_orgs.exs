defmodule App.Repo.Migrations.CreateOrgs do
  use Ecto.Migration

  def change do
    create table(:orgs) do
      add :login, :string
      add :avatar_url, :string
      add :name, :string
      add :company, :string
      add :public_repos, :integer
      add :location, :string
      add :description, :string
      add :followers, :integer

      timestamps()
    end
  end
end
