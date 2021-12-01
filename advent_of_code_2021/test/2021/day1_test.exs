defmodule Afc2021Test.Day1 do
  use ExUnit.Case
  alias AofC2021.Day1

  test "First test" do
    input = ["109", "117", "118", "98", "102", "94"]
    solution = Day1.solve_exercise(input)
    assert solution == nil
  end
end
