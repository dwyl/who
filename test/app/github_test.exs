defmodule App.GitHubTest do
  use ExUnit.Case
  use App.DataCase
  alias App.GitHub

  test "App.GitHub.repository/1" do
    owner = "dwyl"
    reponame = "start-here"
    repo = GitHub.repository(owner, reponame) # |> dbg
    assert repo.stargazers_count > 1700
  end

  test "App.GitHub.user/1" do
    username = "iteles"
    user = GitHub.user(username) # |> dbg
    assert user.public_repos > 30
  end

  test "App.GitHub.org_user_list/1" do
    orgname = "ideaq"
    list = GitHub.org_user_list(orgname)
    assert length(list) > 2
  end

  test "App.GitHub.user/1 known 404 (unhappy path)" do
    username ="kittenking"
    data = App.GitHub.user(username)
    assert data.status == "404"
  end

  test "App.GitHub.org_repos/1 get repos for org" do
    org = "ideaq"
    list = App.GitHub.org_repos(org) # |> dbg
    assert length(list) > 2
  end

  test "App.GitHub.repo_stargazers/2 get stargazers for repo" do
    owner = "dwyl"
    repo = "pizza"
    list = App.GitHub.repo_stargazers(owner, repo) # |> dbg
    assert length(list) > 0
  end
end
