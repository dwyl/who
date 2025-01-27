defmodule App.Reqlog do
  use Ecto.Schema
  import Ecto.Changeset
  alias App.{Repo}
  alias __MODULE__
  require Logger

  schema "reqlogs" do
    field :req, :string
    field :param, :string

    timestamps()
  end

  @doc false
  def changeset(reqlog, attrs) do
    reqlog
    |> cast(attrs, [:req, :param])
    |> validate_required([:req, :param])
  end

  @doc """
  Creates a `reqlog` (request log) record.
  """
  def create(attrs) do
    %Reqlog{}
    |> changeset(attrs)
    |> Repo.insert()
  end

  # clean interface function that can be called from App.GitHub functions
  # e.g: log("repository", "#{owner}/#{reponame}")
  def log(req, param) do
    Logger.info "Fetching #{req} #{param}"
    create(%{req: req, param: param})
  end
end
