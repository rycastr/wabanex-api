defmodule Wabanex.IMCTest do
  use ExUnit.Case, async: true

  alias Wabanex.IMC

  describe "calculate/1" do
    test "when the file exists, returns the data" do
      result = IMC.calculate("test/assets/students.csv")

      expected_result = {:ok, %{"John" => 20.06920415224914}}

      assert result == expected_result
    end

    test "when the wrong filename is given, returns an error" do
      result = IMC.calculate("test/assets/any.csv")

      expected_error = {:error, "Error on read file"}

      assert result == expected_error
    end
  end
end
