defmodule TradelabAssignmentWeb.CurrencyController do
  use TradelabAssignmentWeb, :controller

  @symbols Application.get_env(:tradelab_assignment, TradelabAssignmentWeb.Endpoint)[:symbols]
  def get_currency_price(conn, %{"symbol" => symbol}) do
    case check_for_valid_symbol(symbol) do
      true ->
        data = fetch_data(symbol)
        conn
        |> put_status(200)
        |> json(%{data: data})
      false ->
        conn
        |> put_status(200)
        |> json(%{"message" => "CryptoCurrency not supported"})
    end
  end

  def get_price(conn, _params) do
    data = fetch_all_data();
    conn
    |> put_status(200)
    |> json(%{data: data})
  end

  def fetch_all_data() do
    Enum.reduce(@symbols, %{}, fn symbol, accumulator ->
      data = fetch_data(symbol)
      Map.put(accumulator, symbol, data)
    end)
  end

  def check_for_valid_symbol(symbol) do
    symbol in @symbols
  end

  def fetch_data(symbol) do
    %{
      id: symbol,
      ask: Redix.command!(:redix, ["GET", symbol<>"-ask"]),
      bid: Redix.command!(:redix, ["GET", symbol<>"-bid"]),
      last: Redix.command!(:redix, ["GET", symbol<>"-last"]),
      open: Redix.command!(:redix, ["GET", symbol<>"-open"]),
      low: Redix.command!(:redix, ["GET", symbol<>"-low"]),
      high: Redix.command!(:redix, ["GET", symbol<>"-high"])
    }
  end
end
