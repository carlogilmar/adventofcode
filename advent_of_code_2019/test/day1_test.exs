defmodule Day1Test do
  use ExUnit.Case

  test "Test examples" do
    assert Day1.get_fuel.(12) == 2
    assert Day1.get_fuel.(14) == 2
    assert Day1.get_fuel.(1969) == 654
    assert Day1.get_fuel.(100756) == 33583
  end
end
