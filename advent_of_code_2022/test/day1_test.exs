defmodule ResolverTest do
  use ExUnit.Case
  doctest Resolver
  alias Resolver.Day1

  test "Get sum list grouped by blank line" do
    input = ["1", "2", "3", "", "4", "5", "", "6"]
    expected_group = [6, 9, 6]
    group_by_elfs = Day1.group_by_elfs(input)
    assert expected_group == group_by_elfs
  end

  test "Get the most greater sum of calories" do
    calories = ["1", "2", "3", "", "4", "5", "", "6"]
    assert Day1.get_greather_calories(calories) == 9
  end
end
