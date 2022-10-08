defmodule App.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :login, :string
      add :avatar_url, :string
      add :name, :string
      add :company, :string
      add :bio, :string
      add :blog, :string
      add :location, :string
      add :email, :string
      add :created_at, :string
      add :two_factor_authentication, :boolean, default: false, null: false
      add :followers, :integer
      add :following, :integer
      add :hireable, :boolean, default: false, null: false
      add :public_repos, :integer

      timestamps()
    end
  end
end
