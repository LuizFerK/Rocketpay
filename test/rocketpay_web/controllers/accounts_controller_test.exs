defmodule RocketpayWeb.AccountsControllerTest do
  use RocketpayWeb.ConnCase, async: true

  alias Rocketpay.{Account, User}

  describe "deposit/2" do
    setup %{conn: conn} do
      params = %{
        name: "Luiz",
        password: "123456",
        nickname: "Luuu",
        email: "luizfernandoklein@live.com",
        age: 18
      }

      {:ok, %User{account: %Account{id: account_id}}} = Rocketpay.create_user(params)

      conn = put_req_header(conn, "authorization", "Basic cm9ja2V0cGF5OjEyMzQ1Ng==")

      {:ok, conn: conn, account_id: account_id}
    end

    test "when all params are valid, make the deposit", %{conn: conn, account_id: account_id} do
      params = %{"value" => "50.00"}

      response =
        conn
        |> post(Routes.accounts_path(conn, :deposit, account_id, params))
        |> json_response(:ok)

      assert %{
               "account" => %{"balance" => "50.00", "id" => _id},
               "message" => "Ballance changed successfully"
             } = response
    end

    test "when there are invalid params, return an error", %{conn: conn, account_id: account_id} do
      params = %{"value" => "invalid_value"}

      response =
        conn
        |> post(Routes.accounts_path(conn, :deposit, account_id, params))
        |> json_response(:bad_request)

      expected_response = %{"message" => "Invalid deposit value!"}

      assert response == expected_response
    end
  end

  describe "withdraw/2" do
    setup %{conn: conn} do
      params = %{
        name: "Luiz",
        password: "123456",
        nickname: "Luuu",
        email: "luizfernandoklein@live.com",
        age: 18
      }

      {:ok, %User{account: %Account{id: account_id}}} = Rocketpay.create_user(params)
      Rocketpay.deposit(%{"id" => account_id, "value" => "50.00"})

      conn = put_req_header(conn, "authorization", "Basic cm9ja2V0cGF5OjEyMzQ1Ng==")

      {:ok, conn: conn, account_id: account_id}
    end

    test "when all params are valid, make the withdraw", %{conn: conn, account_id: account_id} do
      params = %{"value" => "25.00"}

      response =
        conn
        |> post(Routes.accounts_path(conn, :withdraw, account_id, params))
        |> json_response(:ok)

      assert %{
               "account" => %{"balance" => "25.00", "id" => _id},
               "message" => "Ballance changed successfully"
             } = response
    end
  end

  describe "transaction/2" do
    setup %{conn: conn} do
      params1 = %{
        name: "Luiz",
        password: "123456",
        nickname: "Luuu",
        email: "luizfernandoklein@live.com",
        age: 18
      }

      params2 = %{
        name: "John Doe",
        password: "123456",
        nickname: "JohnDoe",
        email: "johndoe@example.com",
        age: 18
      }

      {:ok, %User{account: %Account{id: account1_id}}} = Rocketpay.create_user(params1)
      {:ok, %User{account: %Account{id: account2_id}}} = Rocketpay.create_user(params2)
      Rocketpay.deposit(%{"id" => account1_id, "value" => "50.00"})

      conn = put_req_header(conn, "authorization", "Basic cm9ja2V0cGF5OjEyMzQ1Ng==")

      {:ok, conn: conn, account1_id: account1_id, account2_id: account2_id}
    end

    test "when all params are valid, make the withdraw", %{
      conn: conn,
      account1_id: account1_id,
      account2_id: account2_id
    } do
      params = %{"value" => "25.00", "from" => account1_id, "to" => account2_id}

      response =
        conn
        |> post(Routes.accounts_path(conn, :transaction), params)
        |> json_response(:ok)

      assert %{
               "message" => "Transaction done successfully",
               "transaction" => %{
                 "from_account" => %{
                   "balance" => "25.00",
                   "id" => _
                 },
                 "to_account" => %{
                   "balance" => "25.00",
                   "id" => _
                 }
               }
             } = response
    end
  end
end
