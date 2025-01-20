defmodule App.Star do
  alias App.{Repo}
  use Ecto.Schema
  import Ecto.{Changeset, Query}
  require Logger
  alias __MODULE__

  schema "stars" do
    field :stop, :utc_datetime
    field :repo_id, :integer
    field :user_id, :integer

    timestamps()
  end

  @doc false
  def changeset(stars, attrs) do
    stars
    |> cast(attrs, [:repo_id, :user_id, :stop])
    |> validate_required([:repo_id, :user_id])
  end

  @doc """
  Creates a `star` record.
  """
  def create(attrs) do
    %Star{}
    |> changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Get all repositories for an organization and insert them into DB.
  """
  def get_stargazers_for_repo(owner, repo) do
    repo_id = App.Repository.get_repo_id_by_full_name("#{owner}/#{repo}")
    App.GitHub.repo_stargazers(owner, repo)
    |> Enum.map(fn user ->
      dbg(user)
      # %{

      # }
      # create(repo)
    end)
  end
end
