defmodule Identicon do

  def main(input) do
    input
    |> hash_input
    |> pick_color
    |> build_grid

  end

  def hash_input(input) do
    hex = :crypto.hash(:md5, input)
    |> :binary.bin_to_list

    %Identicon.Image{hex: hex}

  end

  def pick_color(%Identicon.Image{hex: [r , g, b | _tail]} = image) do
    # used a tuple instead of a list because each index has a perticular meaning
    %Identicon.Image{image | color: {r,g,b}}
  end

  def build_grid(image) do
    # My try:
    # for row <- Enum.chunk_every(image.hex, 3, 3, :discard) do
    #   mirror_row(row)
    # end

    grid =
      image.hex
      |> Enum.chunk_every(3, 3, :discard)
      |> Enum.map(&mirror_row/1)
      |> List.flatten
      |> Enum.with_index

    %Identicon.Image{ image | grid: grid}
  end

  def mirror_row(row) do
    [first, second | _tail] = row
    row ++ [second, first]
  end
end
