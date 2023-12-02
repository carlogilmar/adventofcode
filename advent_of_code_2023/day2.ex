defmodule Engine do
  @day2 "input/day2.txt"
  @config  %{"red" => 12, "green" => 13, "blue" => 14}

  def read_input(file_name) do
    with {:ok, content} <- File.read(file_name) do
      String.split(content, "\n")
    end
  end

  def process_day2(input_file \\ @day2) do
    input_file
    |> read_input()
    |> Enum.map(&parse_line/1)
    |> Enum.reduce([], fn {:game, game_number, is_valid}, acc ->
      if is_valid do
        acc ++ [game_number]
      else
        acc
      end
    end)
    |> Enum.sum()
  end

  def parse_line(line) do
    [head|[gamesets]] = String.split(line, ": ")

    # Get game number
    ["", game_number] = String.split(head, "Game ")
    game_number = String.to_integer(game_number)

    # Get game sets
    sets_string = String.split(gamesets, "; ")

    sets_validated = Enum.map(sets_string, fn set ->
      sets = String.split(set, ", ")
      Enum.map(sets, fn set ->
        [number, color] = String.split(set, " ")
        number = String.to_integer(number)
        is_valid? = @config[color] >= number
        {number, color, is_valid?}
      end)
    end)

    # Validate which sets are valid
    sets_validation = Enum.map(sets_validated,
      fn set ->
        Enum.all?(set, fn {_,_, is_valid} -> is_valid end)
      end)

    game_validation = Enum.all?(sets_validation, fn set -> set end)

    {:game, game_number, game_validation}
  end
end
