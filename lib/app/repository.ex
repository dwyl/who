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
    field :language, :string
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
    attrs = %{attrs | topics: Enum.join(attrs.topics, ", ")}

    repository
    |> cast(attrs, [
      :created_at,
      :id,
      :description,
      :fork,
      :forks_count,
      :full_name,
      :language,
      :name,
      :open_issues_count,
      :owner_id,
      :pushed_at,
      :stargazers_count,
      :topics,
      :watchers_count
      ])
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

  @doc """
  Get all repositories for an organization and insert them into DB.
  """
  def get_org_repos(org) do
    App.GitHub.org_repos(org)
    |> Enum.map(fn repo ->
      create(repo)
    end)
  end
end
