defmodule Identicon do
  def main(input) do
    input
      |> hash_input
      |> pick_color
      |> build_grid
      |> filter_odd_squares
      |> build_pixel_map
      |> draw_image
      |> save_image(input)
  end

  def hash_input(input) do
     hex =
       :crypto.hash(:md5, input)
         |> :binary.bin_to_list
     %Identicon.Image{hex: hex}
  end

  def pick_color(%Identicon.Image{hex: [red, blue, green | _tail]} = image) do
    %Identicon.Image{image | color: {red, blue, green}}
  end

  def build_grid(%Identicon.Image{hex: hex} = image) do
    grid =
      hex
        |> Enum.chunk(3)
        |> Enum.map(fn [a, b | _tail] = row -> row ++ [b, a] end)
        |> List.flatten
        |> Enum.with_index

    %Identicon.Image{image | grid: grid}
  end

  def filter_odd_squares(%Identicon.Image{grid: grid} = image) do
    grid = grid
             |> Enum.filter(fn {ele, _index} -> rem(ele, 2) == 0 end)

  %Identicon.Image{image | grid: grid}
  end

  def build_pixel_map(%Identicon.Image{grid: grid} = image) do
    pixel = Enum.map(grid, fn {_ele, index} ->
              h = rem(index, 5) * 50
              v = div(index, 5) * 50
                {{h, v}, {h + 50, v + 50}}
            end)

    %Identicon.Image{image | pixel: pixel}
  end

  def draw_image(%Identicon.Image{color: color, pixel: pixel}) do
    image = :egd.create(250, 250)
    fill = :egd.color(color)

    Enum.each(pixel, fn {start, stop} -> 
      :egd.filledRectangle(image, start, stop, fill)
    end)

   :egd.render(image)
  end

  def save_image(image, input) do
    File.write("#{input}.png", image)
  end

end

