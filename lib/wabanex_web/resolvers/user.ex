defmodule WabanexWeb.Resolvers.User do
  def get(%{id: user_id}, _context), do: Wabanex.UseCases.GetUser.call(user_id)

  def create(%{input: params}, _context) do
    Wabanex.UseCases.CreateUser.call(params)
  end
end
