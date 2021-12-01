defmodule AofC2021.Day1 do
  @day_1_input "2021/day1.txt"

  def solve_exercise(input) do
    do_solution(input)
  end

  def solve_exercise do
    input = get_input()
    do_solution(input)
  end

  def do_solution(input) do
    :do_solution
  end

  def get_input() do
    InputReader.get_input(@day_1_input)
  end
end
