defmodule Stack.Stash do
  use GenServer

  def start_link(stack) do
    {:ok, _pid} = GenServer.start_link(__MODULE__, stack)
  end
  def get_stack(pid) do
    GenServer.call(pid, :get)
  end
  def save_stack(pid, stack) do
    GenServer.cast(pid, {:save, stack})
  end

  def handle_call(:get, _from, stack) do
    {:reply, stack, stack}
  end
  def handle_cast({:save, stack}, _stack) do
    {:noreply, stack}
  end
end