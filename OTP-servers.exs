## 1, 2, 3, 4
defmodule Stack.Server do
  use GenServer
  @server_name :stack

  def start_link(stack) do
    GenServer.start_link(__MODULE__, stack, name: @server_name)
  end
  def push(value) do
    GenServer.cast(@server_name, {:push, value})
  end
  def pop() do
    GenServer.call(@server_name, :pop)
  end

  def handle_call(:pop, _from, stack) do
    [head | tail] = stack
    {:reply, head, tail}
  end

  def handle_cast({:push, value}, stack) do
    {:noreply, [value | stack]}
  end
end