defmodule ReportsGeneratorTest do
  use ExUnit.Case

  describe "build/1" do
    test "should build the report" do
      filename = "report_test.csv"

      response = ReportsGenerator.build(filename)

      expected = %{
        "foods" => %{
          "açaí" => 1,
          "churrasco" => 2,
          "esfirra" => 3,
          "hambúrguer" => 2,
          "pastel" => 0,
          "pizza" => 2,
          "prato_feito" => 0,
          "sushi" => 0
        },
        "users" => %{
          "1" => 48,
          "10" => 36,
          "11" => 0,
          "12" => 0,
          "13" => 0,
          "14" => 0,
          "15" => 0,
          "16" => 0,
          "17" => 0,
          "18" => 0,
          "19" => 0,
          "2" => 45,
          "20" => 0,
          "21" => 0,
          "22" => 0,
          "23" => 0,
          "24" => 0,
          "25" => 0,
          "26" => 0,
          "27" => 0,
          "28" => 0,
          "29" => 0,
          "3" => 31,
          "30" => 0,
          "4" => 42,
          "5" => 49,
          "6" => 18,
          "7" => 27,
          "8" => 25,
          "9" => 24
        }
      }

      assert response == expected
    end
  end

  describe "fetch_higher/2" do
    test "when the option equals 'users', should return the user that spent the most" do
      filename = "report_test.csv"

      response =
        filename
        |> ReportsGenerator.build()
        |> ReportsGenerator.fetch_higher("users")

      expected = {:ok, {"5", 49}}

      assert response == expected
    end

    test "when the option equals 'foods', should return the most ordered food category" do
      filename = "report_test.csv"

      response =
        filename
        |> ReportsGenerator.build()
        |> ReportsGenerator.fetch_higher("foods")

      expected = {:ok, {"esfirra", 3}}

      assert response == expected
    end

    test "when the option is invalid, should return an error" do
      filename = "report_test.csv"

      response =
        filename
        |> ReportsGenerator.build()
        |> ReportsGenerator.fetch_higher("bananas")

      expected = {:error, "Invalid option!"}

      assert response == expected
    end
  end
end
