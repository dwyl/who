defmodule App.GitHubTest do
  use ExUnit.Case
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



end
