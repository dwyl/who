defmodule AppWeb.AppLive do
  use AppWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end