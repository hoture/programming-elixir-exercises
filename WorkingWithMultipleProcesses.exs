defmodule WorkingWithMultipleProcesses do
  ## 2
  def echo do
    receive do
      {sender, t} -> send sender, t
    end
  end
  def run2(t1, t2) do
    pid1 = spawn(WorkingWithMultipleProcesses, :echo, [])
    pid2 = spawn(WorkingWithMultipleProcesses, :echo, [])

    send pid1, {self(), t1}
    send pid2, {self(), t2}

    receive do
      ^t1 -> IO.puts t1
    end
    receive do
      ^t2 -> IO.puts t2
    end
  end

  ## 3
  def msg3(sender) do
    send sender, "hello" 
    exit(:boom)
  end
  def run3() do
    import :timer, only: [sleep: 1]

    _pid = spawn_link(WorkingWithMultipleProcesses, :msg3, [self()])
    sleep 500
    receive do
      msg -> IO.inspect msg
    end
  end

  ## 4
  def msg4(sender) do
    send sender, "hello" 
    raise "exception"
  end
  def run4() do
    import :timer, only: [sleep: 1]

    _pid = spawn_link(WorkingWithMultipleProcesses, :msg4, [self()])
    sleep 500
    receive do
      msg -> IO.inspect msg
    end
  end

  ## 5
  def run5() do
    import :timer, only: [sleep: 1]

    _pid = spawn_monitor(WorkingWithMultipleProcesses, :msg3, [self()])
    sleep 500
    receive do
      msg -> IO.inspect msg
    end

    _pid = spawn_monitor(WorkingWithMultipleProcesses, :msg4, [self()])
    sleep 500
    receive do
      msg -> IO.inspect msg
    end
  end
end