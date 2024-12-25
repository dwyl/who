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
end
