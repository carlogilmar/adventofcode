defmodule Afc2021Test.Day3 do
  use ExUnit.Case
  alias AofC2021.Day3

  test "First part: Try the example input from description" do
    input = [
      "00100",
      "11110",
      "10110",
      "10111",
      "10101",
      "01111",
      "00111",
      "11100",
      "10000",
      "11001",
      "00010",
      "01010"
    ]
    solution = Day3.solve_first_part(input)
    assert solution == 198
  end

  test "First part: Try the input" do
    assert 198 == Day3.solve_first_part()
  end

end
