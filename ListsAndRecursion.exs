defmodule ListsAndRecursion do
  # 0
  def sum([]), do: 0
  def sum([head | tail]), do: head + sum(tail)

  # 1
  def mapsum([], _func), do: 0
  def mapsum([head | tail], func), do: func.(head) + mapsum(tail, func)

  # 2
  def max([head | tail]), do: _max(tail, head)
  defp _max([], maxv), do: maxv
  defp _max([head | tail], maxv) when head > maxv, do: _max(tail, head)
  defp _max([_head | tail], maxv), do: _max(tail, maxv)

  # 3
  def ceasar([], _n), do: []
  def ceasar([head | tail], n) when head + n > ?z, do: [(head + n - 26) | ceasar(tail, n)]
  def ceasar([head | tail], n), do: [(head + n) | ceasar(tail, n)]

  # 4
  def span(to, to), do: [to]
  def span(from, to) when from < to, do: [from | span(from + 1, to)]
end