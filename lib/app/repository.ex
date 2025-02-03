defmodule App.Repository do
  use Ecto.Schema
  alias App.{Repo}
  import Ecto.{Changeset} #, Query}
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
    |> Repo.insert(on_conflict: :replace_all, conflict_target: [:id])
  end

  @doc """
  `get_repo_id_by_full_name/1` Gets the repository `id` by `full_name`.
  e.g: get_repo_id_by_full_name("dwyl/start-here") -> 17338019
  """
  def get_repo_id_by_full_name(full_name) do
    repo = Repo.get_by(Repository, [full_name: full_name])
    if is_nil(repo) do
      [owner, reponame] = String.split(full_name, "/")
      {:ok, repo} = App.GitHub.repository(owner, reponame) |> create()

      repo.id
    else
      repo.id
    end
  end

  @doc """
  Get all repositories for an organization and insert them into DB.
  """
  def get_org_repos(org) do
    App.GitHub.org_repos(org)
    |> Enum.map(fn repo ->
      {:ok, inserted_repo} = create(repo)

      inserted_repo
    end)
  end
end

"""
%App.Repository{
  __meta__: #Ecto.Schema.Metadata<:loaded, "repositories">,
  id: 35713694,
  created_at: "2015-05-16T07:06:03Z",
  description: "Effortless Meteor.js Image Uploads",
  fork: true,
  forks_count: 1,
  full_name: "ideaq/image-uploads",
  language: "JavaScript",
  name: "image-uploads",
  open_issues_count: 0,
  owner_id: nil,
  pushed_at: "2016-07-02T12:37:46Z",
  stargazers_count: 5,
  topics: nil,
  watchers_count: 5,
  inserted_at: ~N[2025-01-20 12:27:57],
  updated_at: ~N[2025-01-20 12:27:57]
}
"""
