defmodule App.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :avatar_url, :string
      add :bio, :string
      add :blog, :string
      add :company, :string
      add :created_at, :string
      add :email, :string
      add :followers, :integer
      add :following, :integer
      add :hireable, :boolean, default: false, null: false
      add :location, :string
      add :login, :string
      add :name, :string
      add :public_repos, :integer
      add :two_factor_authentication, :boolean, default: false, null: false

      timestamps()
    end
  end
end
