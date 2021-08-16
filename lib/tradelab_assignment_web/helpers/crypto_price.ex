defmodule TradelabAssignmentWeb.CryptoPriceHelper do
  @crypto_base_url Application.get_env(:tradelab_assignment, TradelabAssignmentWeb.Endpoint)[:crypto_base_url]
  @symbols Application.get_env(:tradelab_assignment, TradelabAssignmentWeb.Endpoint)[:symbols]

  def get_price_from_api(symbol) do
    {:ok, response} =
      @crypto_base_url <> symbol
      |> HTTPoison.get([], params: [])

    Poison.decode!(response.body)
    |> set_price(symbol)
  end

  def get_all_price() do
    {:ok, response} = HTTPoison.get(@crypto_base_url, [], params: [])
    data = Poison.decode!(response.body)
    Enum.each(@symbols, fn symbol ->
      set_price(data[symbol], symbol)
    end)
  end

  def set_price(data, symbol) do
    Redix.command(:redix, ["SET", symbol<>"-ask", data["ask"]])
    Redix.command(:redix, ["SET", symbol<>"-bid", data["bid"]])
    Redix.command(:redix, ["SET", symbol<>"-last", data["last"]])
    Redix.command(:redix, ["SET", symbol<>"-open", data["open"]])
    Redix.command(:redix, ["SET", symbol<>"-low", data["low"]])
    Redix.command(:redix, ["SET", symbol<>"-high", data["high"]])
  end
end
