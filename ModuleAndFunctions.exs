defmodule Times do
  def double(n), do: n * 2

  ## 1, 2
  def triple(n), do: n * 3

  ## 3
  def quadruple(n), do: double(double(n))
end

defmodule ModuleAndFunctions do
  ## 4
  def sum(1), do: 1
  def sum(n), do: n + sum(n - 1)

  ## 5
  def gcd(x, 0), do: x
  def gcd(x, y), do: gcd(y, rem(x, y))

  ## 6
  def guess(a, f..l) when a === div(f + l, 2) do 
    IO.puts "Is it #{a}"
    IO.puts a
  end
  def guess(a, f..l) when a <  div(f + l, 2) do
    m = div(f + l, 2)
    IO.puts "Is it #{m}"
    guess(a, f..(m-1))
  end
  def guess(a, f..l) when a > div(f + l, 2) do
    m = div(f + l, 2)
    IO.puts "is it #{m}"
    guess(a, (m+1)..l)
  end
end