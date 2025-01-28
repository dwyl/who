defmodule App.ApiManager do
  @moduledoc """
  This function manages requests to the `GitHub` API
  To avoid hitting their `5k/h` limit and being blocked.
  Inspired by José Valim's: https://stackoverflow.com/a/32097971/1148249
  """
  use GenServer

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    schedule_work() # Schedule work to be performed at some point
    {:ok, state}
  end

  def handle_info(:work, state) do
    # Do the work you desire here
    schedule_work() # Reschedule once more
    {:noreply, state}
  end

  defp schedule_work() do
    Process.send_after(self(), :work, 2 * 60 * 60 * 1000) # In 2 hours
  end

  def get_users() do
    # Check how many requests have been made in the last hour:

  end
end
