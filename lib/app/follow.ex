defmodule App.Follow do
  alias App.{Repo}
  use Ecto.Schema
  import Ecto.Changeset
  require Logger
  alias __MODULE__

  schema "follows" do
    field :follower_id, :integer
    field :following_id, :integer
    field :stop, :utc_datetime

    timestamps()
  end

  @doc false
  def changeset(follow, attrs) do
    follow
    |> cast(attrs, [:follower_id, :following_id, :stop])
    |> validate_required([:follower_id, :following_id])
  end

  @doc """
  Creates a `follow` record.
  """
  def create(attrs) do
    %Follow{}
    |> changeset(attrs)
    |> Repo.insert()
  end
end
