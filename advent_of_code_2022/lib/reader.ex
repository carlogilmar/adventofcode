defmodule Resolver.Reader do
  def get_input(file_path) do
    base_path = File.cwd!()
    {:ok, text} = File.read("#{base_path}/priv/#{file_path}")
    list = String.split(text, "\n")
    [_empty | input] = Enum.reverse(list)
    Enum.reverse(input)
  end
end
