defmodule App.Repository do
  use Ecto.Schema
  alias App.{Repo}
  import Ecto.Changeset
  require Logger
  alias __MODULE__

  schema "repositories" do
    field :created_at, :string
    field :description, :string
    field :fork, :boolean, default: false
    field :forks_count, :integer
    field :full_name, :string
    field :name, :string
    field :open_issues_count, :integer
    field :owner_id, :integer
    field :pushed_at, :string
    field :stargazers_count, :integer
    field :topics, :string
    field :watchers_count, :integer

    timestamps()
  end

  @doc false
  def changeset(repository, attrs) do
    repository
    |> cast(attrs, [:id, :name, :full_name, :owner_id, :description, :fork, :forks_count, :watchers_count, :stargazers_count, :topics, :open_issues_count, :created_at, :pushed_at])
    |> validate_required([:name, :full_name])
  end

  @doc """
  Creates a `repository`.
  """
  def create(attrs) do
    %Repository{}
    |> changeset(attrs)
    |> Repo.insert()
  end
end
