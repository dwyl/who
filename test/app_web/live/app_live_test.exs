defmodule AppWeb.AppLiveTest do
  use AppWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "sync"
  end
end
