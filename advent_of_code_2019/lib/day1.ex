defmodule Day1 do

  def get_fuel do
    fn
      mass ->
        fuel = div(mass,3) |> Kernel.trunc()
        fuel-2
    end
  end

  def get_fuel_by_element(elements) do
    for element <- elements do
      element = String.to_integer(element)
      get_fuel.(element)
    end
  end

  def get_full_fuel(elements) do
    elements
    |> get_fuel_by_element()
    |> Enum.sum()
  end

  def get_output do
    "day1.txt"
    |> Util.get_input()
    |> get_full_fuel()
  end

end
