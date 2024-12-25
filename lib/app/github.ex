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
    data |> Useful.atomize_map_keys()
  end

  @doc """
  `user/1` Returns the GitHub user profile data.
  """
  def user(username) do
    Logger.info "Fetching user #{username}"
    {_status, data, _res} = Tentacat.Users.find @client, username
    data |> Useful.atomize_map_keys()
  end

end
