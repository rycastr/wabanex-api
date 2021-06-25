defmodule WabanexWeb.SchemaTest do
  use WabanexWeb.ConnCase, async: true

  alias Wabanex.Schemas.User
  alias Wabanex.UseCases.CreateUser

  describe "users query" do
    test "when a valid id is given, returns the user", %{conn: conn} do
      params = %{email: "johndoe@foo.bar", name: "John", password: "any_pass"}

      {:ok, %User{id: user_id}} = CreateUser.call(params)

      query = """
        {
          getUser(id: "#{user_id}") {
            id
            name
            email
          }
        }
      """

      result =
        conn
        |> post("/api/graphql", %{query: query})
        |> json_response(:ok)

      expected_result = %{
        "data" => %{
          "getUser" => %{
            "email" => "johndoe@foo.bar",
            "id" => user_id,
            "name" => "John"
          }
        }
      }

      assert result == expected_result
    end
  end

  describe "users mutation" do
    test "when all params are valid, creates the user", %{conn: conn} do
      mutation = """
        mutation {
          createUser(input: {
            email: "johndoe@foo.bar"
            name: "John"
            password: "any_pass"
          }) {
            id
            name
          }
        }
      """

      result =
        conn
        |> post("/api/graphql", %{query: mutation})
        |> json_response(:ok)

      assert %{"data" => %{"createUser" => %{"id" => _id, "name" => "John"}}} = result
    end
  end
end
