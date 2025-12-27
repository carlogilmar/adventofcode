defmodule Solver do
#      path
#    |> File.stream!()
#    |> Stream.drop(1)
#    |> Stream.map(&String.split(&1, ","))
  #
  # /Users/carlogilmar/Code/GitHub/adventofcode/advent_of_code_2025/solver/priv
  def process_day1(path) do
    path
    |> File.stream!()
    |> Stream.map(&String.split(&1, "\n"))
    |> Enum.each(fn [row, _] ->
      {direction, number} = String.split_at(row, 1)
      Dial.rotate(direction, String.to_integer(number))
    end)
  end

end
