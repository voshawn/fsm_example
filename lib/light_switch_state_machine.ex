defmodule LightSwitchStateMachine do
  @moduledoc """
  A basic light switch using GenStateMachine.
  Supports:
  1. Flipping the light switch
  2. Keeping track of how many times the light has been turned on.

  Start by Running
  ```
  {:ok, pid} = LightSwitchStateMachine.start_link()
  :sys.get_state(pid)
  LightSwitchStateMachine.flip(pid)
  :sys.get_state(pid)
  ```
  """
  use GenStateMachine, callback_mode: :state_functions

  def start_link() do
    GenStateMachine.start_link(__MODULE__, {:off, 0})
  end

  def flip(pid) do
    GenStateMachine.cast(pid, :flip)
  end

  def off(:cast, :flip, count) do
    {:next_state, :on, count + 1}
  end

  def on(:cast, :flip, count) do
    {:next_state, :off, count}
  end
end
