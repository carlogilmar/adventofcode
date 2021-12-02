defmodule AofC2021.Day2 do
  @day_2_input "2021/day2.txt"

  def solve_first_part(input) do
    do_first_solution(input)
  end

  def solve_first_part do
    input = get_input()
    do_first_solution(input)
  end

  defp do_first_solution(input) do
    {horizontal_position, depth_position} =
      Enum.reduce(input, {0,0}, fn instruction, {horizontal, depth} ->
        case parse_instruction(instruction) do
          {"forward", size} ->
            {horizontal+size, depth}
          {"up", size} ->
            {horizontal, depth-size}
          {"down", size} ->
            {horizontal, depth+size}
        end
      end)

    horizontal_position * depth_position
  end

  defp parse_instruction(instruction) do
    [direction, size] = String.split(instruction, " ")
    {direction, String.to_integer(size)}
  end

  ### Second part
  def solve_second_part(input) do
    do_second_solution(input)
  end

  def solve_second_part do
    input = get_input()
    do_second_solution(input)
  end

  defp do_second_solution(input) do
    {horizontal_position, depth_position, _aim} =
      Enum.reduce(input, {0, 0, 0}, fn instruction, {horizontal, depth, aim} ->
        case parse_instruction(instruction) do
          {"forward", size} ->
            {horizontal+size, depth+(aim*size), aim}
          {"up", size} ->
            {horizontal, depth, aim-size}
          {"down", size} ->
            {horizontal, depth, aim+size}
        end
      end)

    horizontal_position * depth_position
  end

  def get_input() do
    InputReader.get_input(@day_2_input)
  end
end
