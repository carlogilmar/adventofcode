defmodule AofC2021.Day3 do
  @day_3_input "2021/day3.txt"

  def solve_first_part do
    @day_3_input |> InputReader.get_input() |> do_first_solution()
  end

  def solve_first_part(input) do
    input |> do_first_solution()
  end

  defp do_first_solution(input) do
    [head | _tail] = input
    input_size = head |> String.codepoints() |> length()
    accumulators = Enum.into(0..input_size, [], fn _ -> [] end)

    accumulators_filled =
      Enum.reduce(input, accumulators, fn item, accumulators ->
        item
        |> String.codepoints()
        |> Enum.zip(accumulators)
        |> Enum.map(fn {element, acc} -> [element | acc] end)
      end)

    final_list_gamma =
      Enum.map(
        accumulators_filled,
        fn acc ->
          case Enum.frequencies(acc) do
            %{"0" => zero, "1" => one} when zero > one -> 0
            %{"0" => zero, "1" => one} when zero < one -> 1
          end
        end
      )

    final_list_epsilon =
      Enum.map(
        accumulators_filled,
        fn acc ->
          case Enum.frequencies(acc) do
            %{"0" => zero, "1" => one} when zero > one -> 1
            %{"0" => zero, "1" => one} when zero < one -> 0
          end
        end
      )

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
    oxygen_rate = get_oxygen_rate(input)
    co2_rate = get_co2_rate(input)
    oxygen_rate * co2_rate
  end

  defp get_oxygen_rate(input) do
    [h | _tail] = input
    size = h |> String.codepoints() |> length()

    [found_number] =
      Enum.reduce(0..(size - 1), input, fn index, input ->
        clean_input_by_bit_position(input, index)
      end)

    {oxygen_rate, ""} =
      found_number
      |> Integer.parse(2)

    oxygen_rate
  end

  defp clean_input_by_bit_position(input, index) do
    positions =
      input
      |> Enum.map(fn item ->
        bit =
          item
          |> String.codepoints()
          |> Enum.at(index)

        {bit, item}
      end)

    bits_to_evaluate = Enum.map(positions, fn {pos, _item} -> pos end)

    bit_champion =
      case Enum.frequencies(bits_to_evaluate) do
        %{"0" => zero, "1" => one} when zero > one -> "0"
        %{"0" => zero, "1" => one} when zero < one -> "1"
        %{"0" => zero, "1" => one} when zero == one -> "1"
        _ -> :pivot
      end

    if bit_champion == :pivot do
      positions
      |> Enum.map(fn {_bit, item} -> item end)
    else
      positions
      |> Enum.filter(fn {bit, _item} -> bit == bit_champion end)
      |> Enum.map(fn {_bit, item} -> item end)
    end
  end

  defp get_co2_rate(input) do
    [h | _tail] = input
    size = h |> String.codepoints() |> length()

    [found_number] =
      Enum.reduce(0..(size - 1), input, fn index, input ->
        clean_input_by_bit_position_for_co2(input, index)
      end)

    {rate, ""} =
      found_number
      |> Integer.parse(2)

    rate
  end

  defp clean_input_by_bit_position_for_co2(input, index) do
    positions =
      input
      |> Enum.map(fn item ->
        bit =
          item
          |> String.codepoints()
          |> Enum.at(index)

        {bit, item}
      end)

    bits_to_evaluate = Enum.map(positions, fn {pos, _item} -> pos end)

    bit_champion =
      case Enum.frequencies(bits_to_evaluate) do
        %{"0" => zero, "1" => one} when zero > one -> "1"
        %{"0" => zero, "1" => one} when zero < one -> "0"
        %{"0" => zero, "1" => one} when zero == one -> "0"
        _ -> :pivot
      end

    if bit_champion == :pivot do
      positions
      |> Enum.map(fn {_bit, item} -> item end)
    else
      positions
      |> Enum.filter(fn {bit, _item} -> bit == bit_champion end)
      |> Enum.map(fn {_bit, item} -> item end)
    end
  end
end
