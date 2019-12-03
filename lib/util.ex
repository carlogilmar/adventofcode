defmodule Util do

  def get_input(file) do
    base_path = File.cwd!
    {:ok, text} = File.read("#{base_path}/priv/input/#{file}")
    list = String.split(text, "\n")
    [_empty | input] = Enum.reverse(list)
		Enum.reverse(input)
  end

end
