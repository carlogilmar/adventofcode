defmodule Tools do
  def run() do
    files = File.ls!(get_tests_path())
    models_by_script = get_models_script()

    for file <- files do
      IO.inspect(file, label: "1) TEST TO CREATE:")
      :ok = create_test_file(file, models_by_script)
    end
  end

  def create_test_file(script_test_name, models_by_script) do
    script_module = get_script_module(script_test_name)
    domain_model = models_by_script[script_module]

    IO.inspect(script_module, label: "2) SCRIPT MODULE:")
    IO.inspect(domain_model, label: "3) DOMAIN MODULE:")

    test_content = get_test_content(script_module, domain_model)

    test_generated_path = "#{get_tests_generated_path()}/#{script_test_name}"
    :ok = File.write(test_generated_path, test_content)
  end

  def get_script_module(script_test_name) do
    [module_name, ""] = String.split(script_test_name, "_script_test.exs")

    if String.contains?(module_name, "_") do
      module_name
      |> String.split("_")
      |> Enum.map(fn word -> String.capitalize(word) end)
      |> Enum.join("")
    else
      String.capitalize(module_name)
    end
  end

  defp get_tests_generated_path do
    "/Users/carlogilmar/Code/GitHub/adventofcode/tools/generated"
  end

  defp get_tests_path do
    "/Users/carlogilmar/Code/ESL/pepsico/b2b-api-ex-v1/apps/api_v1/test/seeds/scripts"
  end

  defp get_scripts_path do
    "/Users/carlogilmar/Code/ESL/pepsico/b2b-api-ex-v1/apps/api_v1/lib/api_v1/scripts"
  end

  defp get_test_content(script_module, domain_model) do
    single_model = String.split(domain_model, ".") |> Enum.reverse() |> List.first()

    """
      defmodule ApiV1.Seeds.Scripts.#{script_module}ScriptTest do
        @moduledoc false
        use ApiV1.Scripts.SeedCase
        alias #{domain_model}
        alias ApiV1.Repo
        alias ApiV1.Scripts.#{script_module}, as: SeedsScript

        @seed_data []

        seed_test "run/0" do

          SeedsScript.run(@seed_data)

          assert [
              %#{single_model}{
          }] = Repo.all(#{single_model})
        end
      end
    """
  end

  @doc """
  %{
   "OrderAttempts" => "ApiV1.Orders.OrderAttempt",
   "Users" => "ApiV1.Users.User",
   "BrandPages" => "ApiV1.BrandPages.BrandPage",
   "SubmittedOrders" => "ApiV1.Orders.SubmittedOrder",
   "Rules" => "ApiV1.Rules.Rule"
  }
  """
  def get_models_script do
    path = get_scripts_path()
    scripts = File.ls!(path)

    for script <- scripts, into: %{} do
      content = File.read!("#{path}/#{script}")
      get_model(content)
    end
  end

  def get_model(content) do
    ["" | [module_name | _tail]] = content |> String.split(["defmodule ApiV1.Scripts.", " do"])
    model_name = get_model_name(content)
    {module_name, model_name}
  end

  def get_model_name(content) do
    [data_type_line] =
      content
      |> String.split("\n")
      |> Enum.filter(fn line -> String.contains?(line, "data_type:") end)

    [model_name | _tail] = data_type_line |> String.split("data_type: ") |> Enum.reverse()

    if String.contains?(model_name, ",") do
      [model | _] = String.split(model_name, ",")
      model
    else
      model_name
    end
  end
end
