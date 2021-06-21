defmodule Wabanex.IMC do
  def calculate(filename) do
    filename
    |> File.read()
    |> handle_file()
  end

  defp handle_file({:ok, content}) do
    result =
      content
      |> String.split("\n")
      |> then(&(&1 -- [""]))
      |> Enum.map(&parse_line/1)
      |> Enum.into(%{})

    {:ok, result}
  end

  defp handle_file({:error, _reason}) do
    {:error, "Error on read file"}
  end

  defp parse_line(line) do
    line
    |> String.split(",")
    |> List.update_at(1, &String.to_float/1)
    |> List.update_at(2, &String.to_float/1)
    |> calculate_imc()
  end

  defp calculate_imc([name, height, weight]) do
    {name, weight / (height * height)}
  end
end
