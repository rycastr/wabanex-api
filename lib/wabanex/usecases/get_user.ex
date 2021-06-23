defmodule Wabanex.UseCases.GetUser do
  alias Wabanex.{Repo, Schemas}
  alias Schemas.User
  alias Ecto.UUID

  def call(id) do
    with {:ok, uuid} <- UUID.cast(id),
         user = %User{} <- Repo.get(User, uuid) do
      {:ok, user}
    else
      :error -> {:error, "Invalid UUID"}
      nil -> {:error, "User not found"}
    end
  end
end
