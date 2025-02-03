defmodule App.GitHubTest do
  use ExUnit.Case
  use App.DataCase
  alias App.GitHub

  test "App.GitHub.followers/1" do
    username = "iteles"
    list = GitHub.followers(username)
    assert length(list) > 400

    # confirm works for an organization:
    org = "dwyl"
    org_followers = GitHub.followers(org)
    assert length(org_followers) > 650
  end

  test "App.GitHub.repository/1" do
    owner = "dwyl"
    reponame = "start-here"
    repo = GitHub.repository(owner, reponame) # |> dbg
    assert repo.stargazers_count > 1700
  end

  test "App.GitHub.repo_contribs/2 returns list of contribs (users)" do
    owner = "dwyl"
    reponame = "start-here"
    contribs = GitHub.repo_contribs(owner, reponame)
    assert length(contribs) > 10
  end

  test "App.GitHub.user/1" do
    username = "iteles"
    user = GitHub.user(username) # |> dbg
    assert user.public_repos > 30
  end

  test "App.GitHub.user_orgs/1" do
    username = "iteles"
    list = GitHub.user_orgs(username) # |> dbg
    assert length(list) > 2

    [org | _] = Enum.filter(list, fn org -> org.login == "dwyl" end)
    assert org.id == 11_708_465
  end

  test "App.GitHub.org_user_list/1" do
    orgname = "ideaq"
    list = GitHub.org_user_list(orgname)
    assert length(list) > 2
  end

  test "App.GitHub.user/1 known 404 (unhappy path)" do
    username = "kittenking"
    data = App.GitHub.user(username)
    assert data.status == "404"
  end

  test "App.GitHub.org/1 get org data" do
    org = App.GitHub.org("ideaq")
    assert org.id == 6_831_072
  end

  test "App.GitHub.org_repos/1 get repos for org" do
    org = "ideaq"
    list = App.GitHub.org_repos(org) # |> dbg
    assert length(list) > 2
  end

  test "App.GitHub.repo_stargazers/2 get stargazers for repo" do
    owner = "dwyl"
    repo = "pizza"
    list = App.GitHub.repo_stargazers("#{owner}/#{repo}") # |> dbg
    assert length(list) > 0
  end
end
