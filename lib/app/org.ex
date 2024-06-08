defmodule App.Org do
  use Ecto.Schema
  import Ecto.Changeset

  schema "orgs" do
    field :name, :string
    field :description, :string
    field :location, :string
    field :login, :string
    field :avatar_url, :string
    field :company, :string
    field :public_repos, :integer
    field :followers, :integer

    timestamps()
  end

  @doc false
  def changeset(org, attrs) do
    org
    |> cast(attrs, [:login, :avatar_url, :name, :company, :public_repos, :location, :description, :followers])
    |> validate_required([:login, :avatar_url, :name, :company, :public_repos, :description, :followers])
  end


end
