defmodule Wabanex.UseCases.CreateUser do
  alias Wabanex.{Repo, Schemas}
  alias Schemas.User

  def call(params) do
    params
    |> User.changeset()
    |> Repo.insert()
  end
end
