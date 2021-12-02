defmodule Afc2021Test.Day2 do
  use ExUnit.Case
  alias AofC2021.Day2

  test "First part: Try the example input from description" do
    input = [
      "forward 5",
      "down 5",
      "forward 8",
      "up 3",
      "down 8",
      "forward 2"
    ]
    solution = Day2.solve_first_part(input)
    assert solution == 150
  end

  test "First Part: Try our input" do
    assert 2019945 == Day2.solve_first_part()
  end

  test "Second part: Try example input" do
    input = [
      "forward 5",
      "down 5",
      "forward 8",
      "up 3",
      "down 8",
      "forward 2"
    ]
    solution = Day2.solve_second_part(input)
    assert solution == 900
  end

  test "Second Part: Try our input" do
    assert 1599311480 == Day2.solve_second_part()
  end
end
