defmodule WabanexWeb.Resolvers.Training do
  def create(%{input: params}, _context) do
    Wabanex.UseCases.CreateTraining.call(params)
  end
end
