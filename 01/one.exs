defmodule Day01.One do
  def calc(input_data) do
    input_data
    |> Enum.map(&String.to_integer/1)
    |> Enum.sum()
  end
end

"input.txt"
|> File.read!()
|> String.split("\n", trim: true)
|> Day01.One.calc()
|> IO.puts()
