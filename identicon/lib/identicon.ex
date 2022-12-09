defmodule Identicon do

  def main(input) do
    input
    |> hash_input
    |> pick_color

  end

  def hash_input(input) do
    hex = :crypto.hash(:md5, input)
    |> :binary.bin_to_list

    %Identicon.Image{hex: hex}

  end

  def pick_color(%Identicon.Image{hex: [r , g, b | _tail]} = input) do
    # used a tuple instead of a list because each index has a perticular meaning
    %Identicon.Image{input | color: {r,g,b}}

  end
end
