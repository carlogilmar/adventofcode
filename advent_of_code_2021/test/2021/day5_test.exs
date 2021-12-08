defmodule Afc2021Test.Day5 do
  use ExUnit.Case
  alias AofC2021.Day5

  test "First part: Try the example input from description" do
    input = [
      "0,9 -> 5,9",
      "8,0 -> 0,8",
      "9,4 -> 3,4",
      "2,2 -> 2,1",
      "7,0 -> 7,4",
      "6,4 -> 2,0",
      "0,9 -> 2,9",
      "3,4 -> 1,4",
      "0,0 -> 8,8",
      "5,5 -> 8,2"
    ]

    solution = Day5.solve_first_part(input)
    assert solution == 5
  end

  test "First part: Try the input" do
    assert 5280 == Day5.solve_first_part()
  end
end
