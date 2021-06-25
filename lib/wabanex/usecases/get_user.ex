defmodule Wabanex.UseCases.GetUser do
  import Ecto.Query

  alias Wabanex.{Repo, Schemas}
  alias Schemas.{Training, User}
  alias Ecto.UUID

  def call(id) do
    UUID.cast(id)
    |> get_user()
    |> load_training()
  end

  def get_user({:ok, uuid}) do
    case Repo.get(User, uuid) do
      nil -> {:error, "User not found"}
      user = %User{} -> {:ok, user}
    end
  end

  def get_user(:error), do: {:error, "Invalid UUID"}

  def load_training({:ok, user}) do
    today = Date.utc_today()

    query =
      from training in Training,
        where: ^today >= training.start_date and ^today <= training.end_date

    result = Repo.preload(user, trainings: {first(query, :inserted_at), :exercises})

    {:ok, result}
  end
end
