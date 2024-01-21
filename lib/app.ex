defmodule TrafficApp.Application do
  use Application

  def start(_type, _args) do
    children = [
      {DynamicSupervisor, strategy: :one_for_one, name: TrafficSupervisor}
    ]

    opts = [strategy: :one_for_one, name: TrafficApp.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
