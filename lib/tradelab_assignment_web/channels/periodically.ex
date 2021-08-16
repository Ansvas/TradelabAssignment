defmodule TradelabAssignmentWeb.Periodically do
  use GenServer
  alias TradelabAssignmentWeb.CryptoPriceHelper

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    schedule_work() # Schedule work to be performed at some point
    {:ok, state}
  end

  def handle_info(:work, state) do
    CryptoPriceHelper.get_all_price()
    schedule_work() # Reschedule once more
    {:noreply, state}
  end

  defp schedule_work() do
    Process.send_after(self(), :work, 30 * 1000) # 30 second
  end
end
