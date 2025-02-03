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
end
