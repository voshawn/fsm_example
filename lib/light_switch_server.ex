defmodule LightSwitchServer do
  @moduledoc """
  A basic light switch using GenServer.
  Supports flipping the switch, and checking the current state.

  Start by Running
  ```
  {:ok, pid} = LightSwitchServer.start_link()
  :sys.get_state(pid)
  LightSwitchServer.flip(pid)
  :sys.get_state(pid)
  ```
  """
  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, :off)
  end

  def flip(pid) do
    GenServer.cast(pid, :flip)
  end

  def init(init) do
    {:ok, init}
  end

  def handle_cast(:flip, :off) do
    {:noreply, :on}
  end

  def handle_cast(:flip, :on) do
    {:noreply, :off}
  end
end
