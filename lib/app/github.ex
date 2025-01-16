defmodule App.GitHub do
  @moduledoc """
  Handles all interactions with the GitHub REST API
  via: github.com/edgurgel/tentacat Elixir GitHub Lib.
  """
  require Logger

  @access_token Application.compile_env(:tentacat, :access_token)
  @client Tentacat.Client.new(%{access_token: @access_token})


  @doc """
  Returns the GitHub repository data.
  """
  def repository(owner, reponame) do
    Logger.info "Fetching repository #{owner}/#{reponame}"
    {_status, data, _res} =
      Tentacat.Repositories.repo_get(@client, owner, reponame)
    data
  end

  @doc """
  Returns the list of GitHub repositories for an Org.
  """
  def org_repos(owner) do
    Logger.info "Fetching list of repositories for #{owner}"
    {_status, data, _res} =
      Tentacat.Repositories.list_orgs(@client, owner)
    data
  end

  @doc """
  `user/1` Returns the GitHub user profile data.
  """
  def user(username) do
    Logger.info "Fetching user #{username}"
    {_status, data, _res} = Tentacat.Users.find(@client, username)
    data
  end

  @doc """
  `org_user_list/1` Returns the list of GitHub users for an org.
  """
  def org_user_list(orgname) do
    Logger.info "Fetching org user list for #{orgname}"
    {_status, data, _res} =
        Tentacat.Organizations.Members.list(@client, orgname)
    data
  end
end
