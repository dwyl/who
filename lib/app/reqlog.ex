defmodule App.Reqlog do
  use Ecto.Schema
  import Ecto.{Changeset, Query}
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

  def req_count_last_hour() do
    # Using `DateTime.add/4` with a negative number to subtract. ;-)
    # via: https://elixirforum.com/t/create-time-with-one-hour-plus/3666/5
    one_hour_ago = DateTime.utc_now(:second) |> DateTime.add(-3600)
    Repo.one(from r in Reqlog, select: count("*"),
      where: r.inserted_at > ^one_hour_ago)
  end
end
