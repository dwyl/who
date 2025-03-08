defmodule App.ApiManagerTest do
  use ExUnit.Case, async: true
  use App.DataCase

  test "App.ApiManager start_link/1 init/1 and handle_info/2" do
    assert App.ApiManager.start_link(nil)
    assert App.ApiManager.init(nil)
    assert App.ApiManager.handle_info(:work, nil)
  end

  test "App.ApiManager.get_users/0" do
    App.GitHub.user("charlie")
    |> Map.delete(:created_at)
    |> App.User.create_incomplete_user_no_overwrite()

    list = App.User.list_incomplete_users()
    assert length(list) > 0

    App.ApiManager.get_users()
  end
end
