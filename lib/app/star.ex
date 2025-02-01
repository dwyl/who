defmodule App.Star do
  alias App.{Repo}
  use Ecto.Schema
  import Ecto.Changeset
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
  `get_stargazers_for_repo/2`
  gets the starts for a given `owner` and `repo` inserts any new `users`.
  """
  def get_stargazers_for_repo(fullname) do
    repo_id = App.Repository.get_repo_id_by_full_name(fullname)
    # dbg("#{fullname} -> #{repo_id}")
    App.GitHub.repo_stargazers(fullname)
    |> Enum.map(fn user ->
      # We have multiple repos over 1k stars
      # Therefore issuing all these requests at once
      # would instantly hit the 5k/h GitHub API Request Limit
      App.User.create_incomplete_user_no_overwrite(user)

      {:ok, star} = create(%{ user_id: user.id, repo_id: repo_id })

      star
    end)
  end
end
