defmodule FileReader do
  def read_input(file_name) do
    with {:ok, content} <- File.read(file_name) do
      String.split(content, "\n")
    end
  end
end

defmodule Engine do

  @day1 FileReader.read_input("input/day1-1.txt")
  def process_day1(input \\ @day1) do
    input
    |> Enum.map(&find_digits_in_line/1)
    |> Enum.map(&get_two_digits/1)
    |> Enum.sum()
  end

  def process_part2(input \\ @day1) do
    input
    |> Enum.map(&replace_digit_letters_in_line/1)
    #|> process_day1()
  end

  def find_digits_in_line(line) do
    line_members = String.codepoints(line)

    Enum.reduce(line_members, [],
      fn index, acc ->
        case Integer.parse(index) do
          {digit, ""} -> acc ++ [digit]
          _other -> acc
        end
    end)
  end

  def get_two_digits([first_digit|_tail] = digits_in_line) do
    [last_digit|_tail] = Enum.reverse(digits_in_line)
    String.to_integer("#{first_digit}" <> "#{last_digit}")
  end

  def replace_digit_letters_in_line( line) do
    numbers = [
      {"one", 1},
      {"two", 2},
      {"three", 3},
      {"four", 4},
      {"five", 5},
      {"six", 6},
      {"seven", 7},
      {"eight", 8},
      {"nine", 9}
    ]

    IO.inspect(line, label: "LINE WITH NUMBERS: ")

    line = Enum.reduce(numbers, line,
      fn {digit_letter, digit}, line ->
        if String.contains?(line, digit_letter) do
          String.replace(line, digit_letter, "#{digit}")
        else
          line
        end
    end)

    IO.inspect(line, label: "LINE FORMATTED: ")
  end

end
