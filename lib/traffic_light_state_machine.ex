defmodule TrafficLightStateMachine do
  @moduledoc """
  A basic traffic light switch using GenStateMachine.
  Supports:
  1. Red, yellow, and green lights
  2. Counting all changes to the light. (State Data)
  3. Logging out the changes to the light. (State Enter)
  4. Changing lights based on timers. (State Timeouts)
  5. Crosswalk button to turn the light red.

  Start by Running
  ```
  {:ok, pid} = TrafficLightStateMachine.start_link()
  TrafficLightStateMachine.crosswalk(pid)
  ```
  """
  use GenStateMachine, callback_mode: [:state_functions, :state_enter]

  def start_link() do
    GenStateMachine.start_link(__MODULE__, {:red, 0})
  end

  def crosswalk(pid) do
    GenStateMachine.cast(pid, :crosswalk)
  end

  def red(:enter, _from_state, count) do
    IO.inspect(change: count, light: "Red")
    {:keep_state_and_data, {:state_timeout, 7_000, :green}}
  end

  def red(:state_timeout, :green, count) do
    {:next_state, :green, count + 1}
  end

  def red(:cast, :crosswalk, _count) do
    :keep_state_and_data
  end

  def green(:enter, _from_state, count) do
    IO.inspect(change: count, light: "Green")
    {:keep_state_and_data, {:state_timeout, 5_000, :yellow}}
  end

  def green(:state_timeout, :yellow, count) do
    {:next_state, :yellow, count + 1}
  end

  def green(:cast, :crosswalk, count) do
    {:next_state, :yellow, count + 1}
  end

  def yellow(:enter, _from_state, count) do
    IO.inspect(change: count, light: "Yellow")
    {:keep_state_and_data, {:state_timeout, 2_000, :red}}
  end

  def yellow(:state_timeout, :red, count) do
    {:next_state, :red, count + 1}
  end

  def yellow(:cast, :crosswalk, _count) do
    :keep_state_and_data
  end
end
