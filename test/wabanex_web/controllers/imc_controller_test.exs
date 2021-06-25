defmodule WabanexWeb.IMCControllerTest do
  use WabanexWeb.ConnCase, async: true

  describe "index/2" do
    test "when the all params are valid, returns the imc info", %{conn: conn} do
      params = %{"file" => %Plug.Upload{
          path: "test/assets/students.csv"
        }
      }

      result =
        conn
        |> post(Routes.imc_path(conn, :index), params)
        |> json_response(:ok)

      expected_result = %{"result" => %{"John" => 20.06920415224914}}

      assert result == expected_result
    end

    test "when there are invalid params, returns an error", %{conn: conn} do
      params = %{"file" => %Plug.Upload{
          path: "test/assets/any.csv"
        }
      }

      result =
        conn
        |> post(Routes.imc_path(conn, :index), params)
        |> json_response(:bad_request)

      expected_result = %{"result" => "Error on read file"}

      assert result == expected_result
    end
  end
end
