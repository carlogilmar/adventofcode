defmodule AofC2021.Day3 do
  @day_3_input "2021/day3.txt"

  def solve_first_part do
    @day_3_input |> InputReader.get_input() |> do_first_solution()
  end

  def solve_first_part(input) do
    input |> do_first_solution()
  end

  defp do_first_solution(input) do
    [head|_tail] = input
    input_size = head |> String.codepoints() |> length()
    accumulators = Enum.into(0..input_size, [], fn _ -> [] end)

    accumulators_filled =
      Enum.reduce(input, accumulators, fn item, accumulators ->
        item
        |> String.codepoints()
        |> Enum.zip(accumulators)
        |> Enum.map(fn {element, acc} -> [element|acc] end)
      end)


    final_list_gamma =
      Enum.map(accumulators_filled,
        fn acc ->
          case Enum.frequencies(acc) do
            %{"0" => zero, "1" => one} when zero > one -> 0
            %{"0" => zero, "1" => one} when zero < one -> 1
          end
        end)

    final_list_epsilon =
      Enum.map(accumulators_filled,
        fn acc ->
          case Enum.frequencies(acc) do
            %{"0" => zero, "1" => one} when zero > one -> 1
            %{"0" => zero, "1" => one} when zero < one -> 0
          end
        end)

    {gamma, ""} =
      final_list_gamma
      |> Enum.join()
      |> Integer.parse(2)

    {epsilon, ""} =
      final_list_epsilon
      |> Enum.join()
      |> Integer.parse(2)

    gamma * epsilon
  end

  def solve_second_part do
    @day_3_input |> InputReader.get_input() |> do_second_solution()
  end

  def solve_second_part(input) do
    input |> do_second_solution()
  end

  defp do_second_solution(input) do
    input
  end
end
