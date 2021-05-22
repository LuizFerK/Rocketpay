defmodule RocketpayWeb.UsersControllerTest do
  use RocketpayWeb.ConnCase, async: true

  describe "create/2" do
    test "when all params are valid, create the user", %{conn: conn} do
      params = %{
        "name" => "John Doe",
        "nickname" => "JhonDoe",
        "age" => 18,
        "email" => "johndoe@example.com",
        "password" => "123456"
      }

      response =
        conn
        |> post(Routes.users_path(conn, :create), params)
        |> json_response(:created)

      assert %{
               "message" => "User created",
               "user" => %{
                 "account" => %{
                   "balance" => "0.00",
                   "id" => _
                 },
                 "id" => _,
                 "name" => "John Doe",
                 "nickname" => "JhonDoe"
               }
             } = response
    end

    test "when there are invalid params, returns an error", %{conn: conn} do
      params = %{
        "name" => "John Doe",
        "nickname" => "JhonDoe",
        "age" => 17,
        "email" => "johndoe@example.com",
        "password" => "123456"
      }

      response =
        conn
        |> post(Routes.users_path(conn, :create), params)
        |> json_response(:bad_request)

      assert %{"message" => %{"age" => ["must be greater than or equal to 18"]}} = response
    end
  end
end
