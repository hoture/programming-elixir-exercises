defmodule ControlFlow do
  ## 1
  def fizzbuzz_upto(n) when n > 0, do: Enum.map(1..n, fn x -> _fizzbuzz(x) end)
  defp _fizzbuzz(x) do
    case {rem(x, 3), rem(x, 5)} do
      {0, 0} -> "FizzBuzz"
      {0, _} -> "Fizz"
      {_, 0} -> "Buzz"
      {_, _} -> x
    end
  end

  ## 3
  def ok!(arg) do
    case arg do
      {:ok, data} -> data
      {_, message} -> raise "error: #{message}"
    end
  end
end