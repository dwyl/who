defmodule App.RepositoryTest do
  use App.DataCase

  test "App.Repository.create/1" do
    repo = %{
      created_at: "2014-03-02T13:20:04Z",
      description: "This your first repo!",
      fork: false,
      forks_count: 110,
      full_name: "dwyl/start-here",
      id: 17338019,
      owner_id: 123,
      owner_name: "dwyl",
      name: "start-here",
      open_issues_count: 98,
      pushed_at: "2022-08-10T07:41:05Z",
      stargazers_count: 1604,
      topics: ["beginner", "beginner-friendly", "how-to", "learn"],
      watchers_count: 1604
    }
    assert {:ok, inserted_repo} = App.Repository.create(repo)
    assert inserted_repo.name == repo.name
  end

  test "App.Repository.get_org_repos/1" do
    App.Repository.get_org_repos("ideaq") # |> dbg
    # assert inserted_repo.name == repo.name
  end

  test "App.Repository.get_repo_id_by_full_name/1" do
    # Get all repos for ideaQ org:
    list = App.Repository.get_org_repos("ideaq")
    full_name = "ideaq/image-uploads"
    repo = Enum.filter(list, fn(r) ->
      r.full_name == full_name
    end)
    |> List.first()

    assert repo.id == App.Repository.get_repo_id_by_full_name(full_name)
  end

end
