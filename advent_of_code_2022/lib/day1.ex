defmodule Resolver.Day1 do
  def resolve_part_1() do
    "2022/day1.txt"
    |> Resolver.Reader.get_input()
    |> get_greather_calories()
  end

  def group_by_elfs(calories) do
    calories
    |> Enum.chunk_by(&(&1 == ""))
    |> Enum.filter(&(&1 != [""]))
    |> Enum.map(&(sum_string_numbers(&1)))
  end

  defp sum_string_numbers(string_numbers) do
    string_numbers
    |> Enum.map(&(String.to_integer(&1)))
    |> Enum.sum()
  end

  def get_greather_calories(calories) do
    calories
    |> group_by_elfs()
    |> Enum.max()
  end
end
