defmodule TrafficStarter do
  @moduledoc """
  Starts a number of traffic light using DynamicSupervisor.

  ```
  TrafficStarter.start_lights(10000)
  ```
  """
  def start_lights(count) do
    Enum.each(1..count, fn _ ->
      DynamicSupervisor.start_child(
        TrafficSupervisor,
        {TrafficLightStateMachine, []}
      )
    end)
  end
end
