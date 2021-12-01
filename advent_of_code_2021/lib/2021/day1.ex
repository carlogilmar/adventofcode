defmodule AofC2021.Day1 do
  @day_1_input "2021/day1.txt"

  def solve_exercise(input) do
    do_solution(input)
  end

  def solve_exercise do
    input = get_input()
    do_solution(input)
  end

  def do_solution(input) do
    input
    |> parse_to_integers()
    |> compare_with_previous_one()
    |> count_increases()
  end

  defp parse_to_integers(input_list) do
    Enum.map(input_list, &String.to_integer/1)
  end

  defp compare_with_previous_one(input_parsed) do
    [first | [second | tail]] = input_parsed
    get_comparisions(first, second, [second | tail], [])
  end

  defp get_comparisions(first, second, [_last], counters) when first > second do
    counters ++ [:decreased]
  end

  defp get_comparisions(first, second, [_last], counters) when first < second do
    counters ++ [:increased]
  end

  defp get_comparisions(first, second, tail, counters) when first > second do
    counters = counters ++ [:decreased]
    [first | [second | tail]] = tail
    get_comparisions(first, second, [second | tail], counters)
  end

  defp get_comparisions(first, second, tail, counters) when first < second do
    counters = counters ++ [:increased]
    [first | [second | tail]] = tail
    get_comparisions(first, second, [second | tail], counters)
  end

  defp count_increases(counters) do
    Enum.count(counters, fn i -> i == :increased end)
  end

  def get_input() do
    InputReader.get_input(@day_1_input)
  end
end
