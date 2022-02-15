defmodule ToolsTest do
  use ExUnit.Case

  test "Get module name" do
    files_names =  ["subscription_metadatas_script_test.exs", "order_attemps_script_test.exs","stories_script_test.exs"]
    expected_modules = ["SubscriptionMetadatas", "OrderAttemps","Stories"]

    for {file, expected_module} <- Enum.zip(files_names, expected_modules) do
      module_name = Tools.get_script_module(file)
      assert module_name == expected_module
    end
  end

test "Get model" do
  file_script =  """
  defmodule ApiV1.Scripts.Addresses do\n  @moduledoc \"\"\"\n  Implementation of ApiV1.Scripts behaviour.\n  \"\"\"\n\n  use ApiV1.Scripts, data_type: ApiV1.Addresses.Address\n\n  @impl Scripts\n  def read do\n    read_data([], functions: [{Users, user_id: 1}, {Admins, admin_id: 1}])\n  end\n\n  @impl Scripts\n  def add_ids(seed_list) do\n    Enum.map(seed_list, fn {name, address} ->\n      {name, Map.put(address, :id, address_id(name, address.nickname))}\n    end)\n  end\n\n  def address_id(name, nickname \\\\ \"fake_seed_address\") do\n    id_gen([name, nickname])\n  end\n\n  def address(user_name) do\n    id = address_id(user_name)\n    {:ok, address} = lookup(%{id: id})\n    address\n  end\nend\n
  """
  assert {"Addresses", "ApiV1.Addresses.Address"} == Tools.get_model(file_script)
end

end
