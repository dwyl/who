defmodule App.Follow do
  alias App.{Repo}
  use Ecto.Schema
  import Ecto.Changeset
  require Logger
  alias __MODULE__

  schema "follows" do
    field :follower_id, :integer, primary_key: true
    field :following_id, :integer, primary_key: true
    field :is_org, :boolean, default: false
    field :stop, :utc_datetime

    timestamps()
  end

  @doc false
  def changeset(follow, attrs) do
    follow
    |> cast(attrs, [:follower_id, :following_id, :is_org, :stop])
    |> unique_constraint(:follows_unique_constraint, name: :follows_unique)
    |> validate_required([:follower_id, :following_id])
  end

  @doc """
  Creates a `follow` record.
  """
  def create(attrs) do
    %Follow{}
    |> changeset(attrs)
    |> Repo.insert(on_conflict: :nothing,
      conflict_target: [:follower_id, :following_id])
  end

  def get_followers_from_api(login, is_org \\ false) do
    # dbg("Login: #{login}, is_org: #{is_org}")
    following_id = get_following_id(login, is_org)
    App.GitHub.followers(login) # |> dbg()
    |> Enum.map(fn user ->
      # dbg(user)
      u = App.User.create_incomplete_user_no_overwrite(user)

      {:ok, _follow} = create(%{
        following_id: following_id,
        follower_id: u.id,
        is_org: is_org
      })

      u
    end)
  end

  def get_following_id(login, is_org \\ false) do
    if is_org do
      org = App.Org.get_org_by_login(login)
      org = if is_nil(org) do
        App.Org.get_org_from_api(%{login: login})
      else
        org
      end

      org.id
    else
      user = App.User.get_user_by_login(login)
      user = if is_nil(user) do
        App.User.get_user_from_api(%{login: login})
      else
        user
      end

      user.id
    end
  end
end
