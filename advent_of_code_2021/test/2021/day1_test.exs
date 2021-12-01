defmodule Afc2021Test.Day1 do
  use ExUnit.Case
  alias AofC2021.Day1

  test "Try the example input from description" do
    input = ["199", "200", "208", "210", "200", "207", "240", "269", "260", "263"]
    solution = Day1.solve_exercise(input)
    assert solution == 7
  end

  test "Getting the first part of the solution" do
    assert 1448 == Day1.solve_exercise()
  end
end
