defmodule App.Contrib do
  use Ecto.Schema
  import Ecto.Changeset
  alias App.{Repo}
  alias __MODULE__

  schema "contribs" do
    field :count, :integer
    field :repo_id, :integer, primary_key: true
    field :user_id, :integer, primary_key: true

    timestamps()
  end

  @doc false
  def changeset(contrib, attrs) do
    contrib
    |> cast(attrs, [:repo_id, :user_id, :count])
    |> unique_constraint(:contribs_unique_constraint, name: :contribs_unique)
    |> validate_required([:repo_id, :user_id, :count])
  end

  @doc """
  Creates a `contribs` record.
  """
  def create(attrs) do
    %Contrib{}
    |> changeset(attrs)
    |> Repo.insert(on_conflict: {:replace, [:count]},
      conflict_target: [:repo_id, :user_id])
  end

  def get_contribs_from_api(fullname) do
    [owner, reponame] = String.split(fullname, "/")
    repo_id = App.Repository.get_repo_id_by_full_name(fullname)
    App.GitHub.repo_contribs(owner, reponame) # |> dbg()
    |> Enum.map(fn user ->
      App.User.create_incomplete_user_no_overwrite(user)
      {:ok, contrib} = create(%{
        repo_id: repo_id,
        user_id: user.id,
        count: user.contributions
      })

      contrib
    end)
  end

end
