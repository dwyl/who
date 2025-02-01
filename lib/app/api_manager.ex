defmodule App.ApiManager do
  @moduledoc """
  This function manages requests to the `GitHub` API
  To avoid hitting their `5k/h` limit and being blocked.
  It checks the request log each minute for the number of API requests made
  in the last hour. If requests < 4920, then back-fill the incomplete users.
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
    get_users() # get the incomplete users from the API
    schedule_work() # Reschedule once more
    {:noreply, state}
  end

  defp schedule_work() do
    Process.send_after(self(), :work, 60 * 1000) # check again in 1 minute
  end

  def get_users() do
    # Check how many requests have been made in the last hour:
    count = App.Reqlog.req_count_last_hour()
    # Q: Why 4920...?
    # A: API limit is 5,000 requests per hour
    # 5000 / 60 min = 83.33 (requests per minute)
    # 5000 - 83 = 4917 ... so rounded to 4920.
    if count < 4920 do
      # Get the top 80 users that need to be queried:
      App.User.list_incomplete_users()
      |> Enum.each(fn user ->
        # Get and insert the full user data:
        App.User.get_user_from_api(user)
        App.Orgmember.get_orgs_for_user(user)
      end)

      App.Org.list_incomplete_orgs()
      |> Enum.each(fn org ->
        App.Org.get_org_from_api(org)
      end)

    end
  end
end
