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
end
