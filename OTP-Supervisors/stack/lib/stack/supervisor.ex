defmodule Stack.Supervisor do
  use Supervisor

  def start_link(initial_stack) do
    {:ok, sup_pid} = Supervisor.start_link(__MODULE__, [initial_stack])

    {:ok, stash_pid} = Supervisor.start_child(sup_pid, worker(Stack.Stash, [initial_stack]))
    {:ok, _subsup_pid} = Supervisor.start_child(sup_pid, supervisor(Stack.SubSupervisor, [stash_pid]))

    {:ok, sup_pid}
  end
  def init(_) do
    supervise([], strategy: :one_for_one)
  end
end