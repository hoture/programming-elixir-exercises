defmodule Stack.Server do
  use GenServer

  def start_link(stash_pid) do
    {:ok, _pid} = GenServer.start_link(__MODULE__, stash_pid, name: __MODULE__)
  end
  def push(value) do
    GenServer.cast(__MODULE__, {:push, value})
  end
  def pop() do
    GenServer.call(__MODULE__, :pop)
  end

  def init(stash_pid) do
    stack = Stack.Stash.get_stack(stash_pid)
    {:ok, {stack, stash_pid}}
  end
  def handle_call(:pop, _from, {stack, stash_pid}) do
    [head | tail] = stack
    {:reply, head, {tail, stash_pid}}
  end
  def handle_cast({:push, value}, {stack, stash_pid}) do
    {:noreply, {[value | stack], stash_pid}}
  end
end