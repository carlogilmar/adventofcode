defmodule AofC2021.Day4 do
  @day_4_input "2021/day4.txt"

  def solve_first_part do
    @day_4_input |> InputReader.get_input() |> do_first_solution()
  end

  def solve_first_part(input) do
    input |> do_first_solution()
  end

  defp do_first_solution(input) do
    [numbers | boards_input] = input
    numbers = String.split(numbers, ",")

    boards =
      boards_input
      |> Enum.chunk_every(6)
      |> Enum.map(&Board.create_board/1)

    play_bingo(boards, numbers, nil)
  end

  def play_bingo(boards, [number | numbers], nil) do
    boards_updated = Enum.map(boards, &Board.run_bingo_number(&1, number))

    winner_row =
      Enum.find(
        boards_updated,
        fn board ->
          board.status == :selected
        end
      )

    game_status =
      if is_nil(winner_row) do
        nil
      else
        winner_row
      end

    play_bingo(boards_updated, numbers, game_status)
  end

  def play_bingo(boards, _numbers, _row_winner) do
    winner_board =
      Enum.find(
        boards,
        fn board ->
          board.status == :selected
        end
      )

    winner_numbers =
      Enum.map(
        winner_board.rows,
        fn {row, _status} ->
          Enum.into(row, [], fn {number, state} ->
            if state == :selected do
              0
            else
              String.to_integer(number)
            end
          end)
        end
      )

    unmarked_number =
      winner_numbers
      |> Enum.map(&Enum.sum/1)
      |> Enum.sum()

    last_bingo_number =
      winner_board.numbers
      |> List.last()
      |> String.to_integer()

    unmarked_number * last_bingo_number
  end
end

defmodule Board do
  defstruct [:status, :numbers, :rows, :winner_row]

  def create_board([_empty_row | board_rows]) do
    rows =
      Enum.map(board_rows, fn board_row ->
        row =
          board_row
          |> String.split()
          |> Enum.map(fn item -> {item, :ready} end)

        {row, :ready}
      end)

    %__MODULE__{status: :ready, numbers: [], rows: rows}
  end

  def run_bingo_number(%__MODULE__{numbers: numbers} = board, number) do
    {rows_updated, status_updated, winner_row} = update_rows(board, number)

    board
    |> Map.put(:numbers, numbers ++ [number])
    |> Map.put(:rows, rows_updated)
    |> Map.put(:status, status_updated)
    |> Map.put(:winner_row, winner_row)
  end

  def update_rows(%{rows: rows, status: status} = _board, number) do
    rows_updated = Enum.map(rows, &update_row(&1, number))
    {status_updated, winner_row} = get_board_status(rows_updated, status)
    {rows_updated, status_updated, winner_row}
  end

  def get_board_status(rows_updated, status) do
    winner_row =
      Enum.find(
        rows_updated,
        fn {_rows, status} ->
          status == :selected
        end
      )

    case winner_row do
      nil -> {status, nil}
      {row, :selected} -> {:selected, row}
    end
  end

  def update_row({row, status}, number) do
    row_updated =
      Enum.into(row, [], fn {row_number, row_status} ->
        if row_number == number do
          {row_number, :selected}
        else
          {row_number, row_status}
        end
      end)

    row_status =
      row_updated
      |> Enum.map(fn {_row, status} -> status end)
      |> Enum.count(fn status -> status == :selected end)

    status_updated =
      if row_status == 5 do
        :selected
      else
        status
      end

    {row_updated, status_updated}
  end
end
