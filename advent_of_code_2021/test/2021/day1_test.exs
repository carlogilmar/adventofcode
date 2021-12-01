defmodule Afc2021Test.Day1 do
  use ExUnit.Case
  alias AofC2021.Day1

  test "First part: Try the example input from description" do
    input = ["199", "200", "208", "210", "200", "207", "240", "269", "260", "263"]
    solution = Day1.solve_first_part(input)
    assert solution == 7
  end

  test "First part: Getting the first part of the solution" do
    assert 1448 == Day1.solve_first_part()
  end

  test "Second part: Try example from description" do
    input = ["199", "200", "208", "210", "200", "207", "240", "269", "260", "263"]
    solution = Day1.solve_second_part(input)
    assert solution == 5
  end

  test "Second part: Getting the first part of the solution" do
    assert 1471 == Day1.solve_second_part()
  end
end
