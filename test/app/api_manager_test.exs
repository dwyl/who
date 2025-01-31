defmodule App.ApiManagerTest do
  use ExUnit.Case, async: true
  use App.DataCase

  test "App.ApiManager start_link/1 init/1 and handle_info/2" do
    assert App.ApiManager.start_link(nil)
    assert App.ApiManager.init(nil)
    assert App.ApiManager.handle_info(:work, nil)
  end

  test "App.ApiManager.get_users/0" do
    dummy_data = App.User.dummy_data(%{id: 42})
    App.User.create_incomplete_user_no_overwrite(dummy_data)
    list = App.User.list_incomplete_users()
    assert length(list) > 0

    App.ApiManager.get_users()
  end
end
