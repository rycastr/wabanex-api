defmodule Wabanex.Schemas.UserTest do
  use Wabanex.DataCase, async: true

  alias Wabanex.Schemas.User

  describe "changeset/1" do
    test "when all params are valid, returns a valid changeset" do
      params = %{name: "John", email: "johndoe@foo.bar", password: "any_pass"}

      result = User.changeset(params)

      assert %Ecto.Changeset{
               valid?: true,
               changes: ^params,
               errors: []
             } = result
    end

    test "when there are invalid params, returns a invalid changeset" do
      params = %{name: "J", email: "johndoe@foo.bar"}

      result = User.changeset(params)

      expected_error = %{
        name: ["should be at least 2 character(s)"],
        password: ["can't be blank"]
      }

      assert errors_on(result) == expected_error
    end
  end
end
