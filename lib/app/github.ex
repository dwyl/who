defmodule App.GitHub do
  @moduledoc """
  Handles all interactions with the GitHub REST API
  via: github.com/edgurgel/tentacat Elixir GitHub Lib.
  """
  import App.Reqlog, only: [log: 2]

  @access_token Application.compile_env(:tentacat, :access_token)
  @client Tentacat.Client.new(%{access_token: @access_token})

  @doc """
  Returns org data.
  """
  def followers(login) do
    log("followers", login)
    {_status, data, _res} =
      Tentacat.Users.Followers.followers(@client, login)
    data
  end

  @doc """
  Returns org data.
  """
  def org(login) do
    log("org", login)
    {_status, data, _res} =
      Tentacat.Organizations.find(@client, login)
    data
  end

  @doc """
  Returns the list of GitHub repositories for an Org.
  """
  def org_repos(owner) do
    log("org_repos", owner)
    {_status, data, _res} =
      Tentacat.Repositories.list_orgs(@client, owner)
    data
  end

  @doc """
  Returns the GitHub repository data.
  """
  def repository(owner, reponame) do
    log("repository", "#{owner}/#{reponame}")
    {_status, data, _res} =
      Tentacat.Repositories.repo_get(@client, owner, reponame)
    data
  end

  @doc """
  `repo_stargazers/2` Returns the list of GitHub users starring a repo.
  `owner` - the owner of the repo
  `repo` - name of the repo to check stargazers for.
  """
  def repo_stargazers(fullname) do
    [owner, repo] = String.split(fullname, "/")
    log("repo_stargazers", "#{owner}/#{repo}")
    {_status, data, _res} =
      Tentacat.Users.Starring.stargazers(@client, owner, repo)
    data
  end

  @doc """
  `user/1` Returns the GitHub user profile data.
  """
  def user(username) do
    log("user", username)
    {_status, data, _res} = Tentacat.Users.find(@client, username)
    data
  end

    @doc """
  `user_orgs/1` Returns the list of `public` GitHub orgs for a user.
  """
  def user_orgs(username) do
    log("user_orgs", username)
    {_status, data, _res} =  Tentacat.Organizations.list(@client, username)
    data
  end

  @doc """
  `org_user_list/1` Returns the list of GitHub users for an org.
  """
  def org_user_list(orgname) do
    log("org_user_list", orgname)
    {_status, data, _res} =
        Tentacat.Organizations.Members.list(@client, orgname)
    data
  end
end
