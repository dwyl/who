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
      add :hex, :string
      add :location, :string
      add :login, :string #, primary_key: true
      add :name, :string
      add :public_repos, :integer
      add :show, :boolean, default: false

      timestamps()
    end

    # drop_if_exists index(:orgs, [:login])
    # create unique_index(:orgs, :login, name: :org_login_unique)
  end
end
