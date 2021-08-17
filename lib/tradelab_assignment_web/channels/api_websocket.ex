defmodule TradelabAssignmentWeb.ApiWebSocket do
  alias TradelabAssignmentWeb.CryptoPriceHelper
  use WebSockex
  require Logger

  def start_link(opts \\ []) do
    WebSockex.start_link("wss://api.hitbtc.com/api/3/ws/public", __MODULE__, :fake_state, opts)
  end

  def get_data_from_hitbtc(client) do
    message =
    %{
      method: "subscribe",
      ch: "orderbook/top/1000ms",
      params: %{
          symbols: ["ETHBTC", "BTCUSDT"]
      },
      id: 123
    }
    |> Poison.encode!()
    WebSockex.send_frame(client, {:text, message})
  end

  def handle_connect(_conn, state) do
    {:ok, state}
  end

  def handle_frame({:text, msg}, :message_received) do
    CryptoPriceHelper.set_price(msg["data"], Enum.at(Map.keys(msg["data"]),0))
  end

  def handle_disconnect(disconnect_map, state) do
    super(disconnect_map, state)
  end
end
