defmodule Day01.Two do
  def calc(input_data) do
    input_data
    |> Enum.map(&String.to_integer/1)
    # the input needs to be looped over repeatedly until a total repeats, so
    # cycle it into an infinite stream and stop as soon as we see a duplicate
    |> Stream.cycle()
    |> Enum.reduce_while({0, MapSet.new([0])}, fn shift, {total, seen} ->
      total = total + shift

      if MapSet.member?(seen, total) do
        {:halt, total}
      else
        {:cont, {total, MapSet.put(seen, total)}}
      end
    end)
  end
end

"input.txt"
|> File.read!()
|> String.split("\n", trim: true)
|> Day01.Two.calc()
|> then(&IO.puts("FOUND: #{&1}"))
