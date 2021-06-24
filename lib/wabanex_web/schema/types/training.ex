defmodule WabanexWeb.Schema.Types.Training do
  use Absinthe.Schema.Notation

  import_types WabanexWeb.Schema.Types.Exercise

  @desc "Logic training reprensentation"
  object :training do
    field :id, non_null(:uuid4)
    field :start_date, non_null(:string)
    field :end_date, non_null(:string)
    field :exercises, list_of(:exercise)
  end

  input_object :create_training_input do
    field :user_id, non_null(:string), description: "Trainings user id"
    field :start_date, non_null(:string), description: "Trainings start date"
    field :end_date, non_null(:string), description: "Trainings end date"
    field :exercises, list_of(:create_exercise_input), description: "Trainings exercises"
  end
end
