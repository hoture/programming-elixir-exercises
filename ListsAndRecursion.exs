defmodule ListsAndRecursion do
  ## 0
  def sum([]), do: 0
  def sum([head | tail]), do: head + sum(tail)

  ## 1
  def mapsum([], _func), do: 0
  def mapsum([head | tail], func), do: func.(head) + mapsum(tail, func)

  ## 2
  def max([head | tail]), do: _max(tail, head)
  defp _max([], maxv), do: maxv
  defp _max([head | tail], maxv) when head > maxv, do: _max(tail, head)
  defp _max([_head | tail], maxv), do: _max(tail, maxv)

  ## 3
  def ceasar([], _n), do: []
  def ceasar([head | tail], n) when head + n > ?z, do: [(head + n - 26) | ceasar(tail, n)]
  def ceasar([head | tail], n), do: [(head + n) | ceasar(tail, n)]

  ## 4
  def span(to, to), do: [to]
  def span(from, to) when from < to, do: [from | span(from + 1, to)]

  ## 5
  def all?([], _func), do: true
  def all?([head | tail], func), do: func.(head) and all?(tail, func)

  def each([], _func), do: :ok
  def each([head | tail], func) do
    func.(head)
    each(tail, func)
  end

  def filter([], _func), do: []
  def filter([head | tail], func) do
    if func.(head) do
      [head | filter(tail, func)]
    else
      filter(tail, func)
    end
  end

  def split(list, count), do: _split(list, [], count)
  defp _split([], front, _count), do: [Enum.reverse(front), []]
  defp _split(list, front, 0), do: [Enum.reverse(front), list]
  defp _split([head | tail], front, count), do: _split(tail, [head | front], count - 1)

  def take([], _count), do: []
  def take(_list, 0), do: []
  def take([head | tail], count), do: [head | take(tail, count - 1)]

  ## 6
  def flatten([]), do: []
  def flatten([head | tail]) do
    if is_list(head) do
      [head_h | tail_h] = head
      [head_h | flatten(tail_h ++ tail)]
    else
      [head | flatten(tail)]
    end
  end

  ## 7
  def primes(n) do
    for x <- span(2, n), is_prime?(x), do: x
  end
  defp is_prime?(2), do: true
  defp is_prime?(x) do
    Enum.all?(span(2, x - 1), &(rem(x, &1) > 0))
  end

  ## 8
  def add_totals(orders, tax_rates) do
    Enum.map(orders, fn order -> _add_total(order, tax_rates) end)
  end
  defp _add_total(order = [id: _i, ship_to: s, net_amount: n], tax_rates) do
    tax_rate = Keyword.get(tax_rates, s, 0)
    Keyword.put(order, :total_amount, n * (1 + tax_rate))
  end
end