defmodule TradelabAssignmentWeb.PageController do
  use TradelabAssignmentWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
