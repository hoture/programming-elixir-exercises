defmodule StringsAndBinaries do
  ## 1
  def is_ascii?(ch_list) do
    ascii_range = ?\s..?~
    Enum.all?(ch_list, fn ch -> ch in ascii_range end)
  end

  ## 2
  def anagram?([], []), do: true
  def anagram?([], _word2), do: false
  def anagram?(_word1, []), do: false
  def anagram?([head | tail], word2) do
    next_word2 = word2 -- [head]  
    anagram?(tail, next_word2)
  end

  ## 3
  # iex> [[1, 2, 3] | [4, 5, 6]]
  # [[1, 2, 3], 4, 5, 6]
  # と同じで、[head | tail]においてtailの方だけ中身が展開されるため

  ## 4
  def calculate(charlist) do
    list = to_string(charlist) |> String.split
    _calculate(list)
  end
  defp _calculate([a, "+", b]), do: String.to_integer(a) + String.to_integer(b)
  defp _calculate([a, "-", b]), do: String.to_integer(a) - String.to_integer(b)
  defp _calculate([a, "*", b]), do: String.to_integer(a) * String.to_integer(b)
  defp _calculate([a, "/", b]), do: String.to_integer(a) / String.to_integer(b)

  ## 5
  def center(word_list) do
    max_length = Enum.max_by(word_list, fn word -> String.length(word) end) |> String.length
    IO.puts max_length
    word_list_w_spaces = Enum.map(word_list, fn word -> _add_spaces(word, div(max_length - String.length(word), 2)) end)
    Enum.each(word_list_w_spaces, fn word -> IO.puts word end)
  end
  defp _add_spaces(word, 0), do: word
  defp _add_spaces(word, num_spaces) do
    _add_spaces(" " <> word, num_spaces - 1)
  end
end