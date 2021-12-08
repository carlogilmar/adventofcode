defmodule AofC2021.Day5 do
  @day_4_input "2021/day5.txt"

  def solve_first_part() do
    @day_4_input |> InputReader.get_input() |> do_first_solution(999)
  end

  def solve_first_part(input) do
    input |> do_first_solution()
  end

  defp do_first_solution(input, size \\ 9) do
    coordinates = parse_input(input)
    diagram = create_diagram(size)

    diagram_updated =
      Enum.reduce(
        coordinates,
        diagram,
        fn [from, to], diagram ->
          print_line(diagram, from, to)
        end
      )

    diagram_updated
    |> count_overlaps()
    |> Enum.sum()
  end

  def count_overlaps(diagram) do
    Enum.reduce(
      diagram,
      [],
      fn row, acc ->
        rows_overlaping = Enum.count(row, fn e -> e >= 2 end)
        acc ++ [rows_overlaping]
      end
    )
  end

  def parse_input(input) do
    Enum.map(input, &parse_input_line/1)
  end

  def parse_input_line(line) do
    [from, "->", to] = String.split(line)

    Enum.map(
      [from, to],
      fn coordinate ->
        [x, y] = String.split(coordinate, ",")
        {String.to_integer(x), String.to_integer(y)}
      end
    )
  end

  def create_diagram(size) do
    for _e <- 0..size, do: Enum.map(0..size, fn _ -> 0 end)
  end

  def print_line(diagram, from, to) do
    coordinates = get_coordinates_to_print(from, to)

    Enum.reduce(coordinates, diagram, fn coordinate, diagram ->
      print_coordinate(diagram, coordinate)
    end)
  end

  def print_coordinate(diagram, {x, y}) do
    Enum.with_index(
      diagram,
      fn column, index ->
        if index == x do
          current_value = Enum.at(column, y)
          List.replace_at(column, y, current_value + 1)
        else
          column
        end
      end
    )
  end

  def get_coordinates_to_print({x1, y1}, {x2, y2}) when x1 == x2 do
    range =
      if y1 < y2 do
        y1..y2
      else
        y2..y1
      end

    for idx <- range, do: {x1, idx}
  end

  def get_coordinates_to_print({x1, y1}, {x2, y2}) when y1 == y2 do
    range =
      if x1 < x2 do
        x1..x2
      else
        x2..x1
      end

    for idx <- range, do: {idx, y1}
  end

  def get_coordinates_to_print(_, _) do
    []
  end
end
