defmodule App.GitHubTest do
  use ExUnit.Case
  alias App.GitHub

  test "App.GitHub.repository/1" do
    owner = "dwyl"
    reponame = "start-here"

    GitHub.repository(owner, reponame) |> IO.inspect
    # assert html_response(conn, 200) =~ "LiveView App Page"
  end

  test "App.GitHub.user/1" do
    user = "iteles"
    GitHub.user(user) # |> IO.inspect
    # assert html_response(conn, 200) =~ "LiveView App Page"
  end
end