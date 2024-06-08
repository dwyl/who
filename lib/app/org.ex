defmodule App.Org do
  alias App.{Repo}
  use Ecto.Schema
  import Ecto.Changeset
  require Logger
  alias __MODULE__

  schema "orgs" do
    field :avatar_url, :string
    field :blog, :string
    field :company, :string
    field :description, :string
    field :followers, :integer
    field :location, :string
    field :login, :string
    field :name, :string
    field :public_repos, :integer

    timestamps()
  end

  @doc false
  def changeset(org, attrs) do
    org
    |> cast(attrs, [:login, :avatar_url, :name, :company, :public_repos, :location, :description, :followers])
    |> validate_required([:login, :avatar_url, :name, :company, :public_repos, :description, :followers])
  end

  @doc """
  Creates an `org`.
  """
  def create(attrs) do
    %Org{}
    |> changeset(attrs)
    |> Repo.insert()
  end
end
