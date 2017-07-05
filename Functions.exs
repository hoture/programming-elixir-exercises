defmodule Functions do
  ## 1
  def list_concat(l1, l2), do: l1 ++ l2 
  def sum(a, b, c), do: a + b + c
  def pair_tuple_to_list({a, b}), do: [a, b]

  ## 2
  def _fizzbuzz(0, 0, _), do: "FizzBuzz"
  def _fizzbuzz(0, _, _), do: "Fizz"
  def _fizzbuzz(_, 0, _), do: "Buzz"
  def _fizzbuzz(_, _, a), do: a

  ## 3
  def fizzbuzz(n), do: _fizzbuzz(rem(n, 3), rem(n, 5), n)

  ## 4
  def prefix(pre) do
    fn arg -> pre <> " " <> arg end
  end

  ## 4
  def add2(list), do: Enum.map(list, &(&1 + 2))
  def inspect(list), do: Enum.each(list, &(IO.inspect &1))
end