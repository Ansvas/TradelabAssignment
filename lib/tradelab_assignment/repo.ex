defmodule TradelabAssignment.Repo do
  use Ecto.Repo,
    otp_app: :tradelab_assignment,
    adapter: Ecto.Adapters.Postgres
end
