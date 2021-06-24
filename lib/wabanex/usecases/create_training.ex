defmodule Wabanex.UseCases.CreateTraining do
  alias Wabanex.{Schemas, Repo}
  alias Schemas.Training

  def call(params) do
    params
    |> Training.changeset()
    |> Repo.insert()
  end
end
