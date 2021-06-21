defmodule WabanexWeb.IMCController do
  use WabanexWeb, :controller

  alias Wabanex.IMC

  def index(conn, %{"file" => %Plug.Upload{path: path}}) do
    IMC.calculate(path)
    |> handle_response(conn)
  end

  defp handle_response({:ok, result}, conn) do
    render_response(conn, result, :ok)
  end

  defp handle_response({:error, result}, conn) do
    render_response(conn, result, :bad_request)
  end

  defp render_response(conn, result, status) do
    conn
    |> put_status(status)
    |> json(%{result: result})
  end
end
