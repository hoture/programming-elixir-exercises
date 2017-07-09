## 3
defmodule Ticker do
  @interval 2000
  @ticker_name :ticker

  def start do
    ticker_pid = spawn(__MODULE__, :generator, [[], 0])
    :global.register_name(@ticker_name, ticker_pid)
  end

  def register(client_pid) do
    send :global.whereis_name(@ticker_name), {:register, client_pid}
  end

  def generator(clients, next_client_idx) do
    receive do
      {:register, pid} ->
        IO.puts "registering #{inspect pid}"
        generator([pid | clients], next_client_idx)
    after
      @interval ->
        IO.puts "tick"
        _send_tick_to_client(clients, next_client_idx)
        generator(clients, next_client_idx + 1)
    end
  end

  defp _send_tick_to_client([], _), do: nil
  defp _send_tick_to_client(clients, next_client_idx) do
    {:ok, client_pid} = Enum.reverse(clients) |> Enum.fetch(rem(next_client_idx, length(clients)))
    send client_pid, {:tick}
  end
end

defmodule Client do
  def start do
    pid = spawn(__MODULE__, :receiver, [])
    Ticker.register(pid)
  end

  def receiver do
    receive do
      {:tick} -> 
        IO.puts "tock"
        receiver()
    end
  end
end

## 4
defmodule Ring do
  def start do
    pid = spawn(__MODULE__, :manager, [[]])    
    :global.register_name(:manager, pid)
    {:ok, agent_pid} = Agent.start_link(fn -> %{} end)
    :global.register_name(:agent, agent_pid)
  end

  def register(new_client) do
    send :global.whereis_name(:manager), {:register, new_client}
  end

  def set_state(field, value) do
    Agent.update(:global.whereis_name(:agent), fn map -> Map.put(map, field, value) end)
  end
  def get_state(field) do
    Agent.get(:global.whereis_name(:agent), fn map -> Map.get(map, field) end)
  end
  def get_and_update_state(field, next_value) do
    Agent.get_and_update(
      :global.whereis_name(:agent), 
      fn map -> 
        {Map.get(map, field), Map.put(map, field, next_value)}
      end
    )
  end

  def manager(clients) do
    receive do
      {:register, new_client} -> 
        case length(clients) do
          0 -> 
            set_state(:oldest, new_client)
            set_state(:most_recent, new_client)
            send new_client, {:send_to, new_client}
            receive do
              {:ok} -> send new_client, {:tick}
            end
            manager([new_client])
          _ ->
            most_recent = get_and_update_state(:most_recent, new_client)
            send new_client, {:send_to, most_recent}
            oldest = get_state(:oldest)
            send oldest, {:send_to, new_client}
            manager([new_client | clients])
        end
    end
  end
end

defmodule RingClient do
  @interval 2000
  def start do
    pid = spawn(__MODULE__, :client, [])
    Ring.register(pid)
  end

  def client do
    receive do
      {:send_to, next} -> 
        client(next)
    end
  end
  def client(next) do
    send :global.whereis_name(:manager), {:ok}
    receive do
      {:send_to, next} -> 
        client(next)
      {:tick} -> 
        IO.puts "tock"
        Process.sleep @interval
        IO.puts "tick to #{inspect next}"
        send next, {:tick}
        client(next)
    end
  end
end