defmodule Dial do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  @impl true
  def init(_) do
    IO.puts("Start dial!")

    state = %{
      coincidences: 0,
      pointer: 50,
      records: []
    }

    {:ok, state}
  end

  def rotate(direction, number) do
    IO.puts("Rotating...")
    GenServer.cast(__MODULE__, {:rotate, direction, number})
  end

  def pointer do
    GenServer.call(__MODULE__, :pointer)
  end

  def records do
    GenServer.call(__MODULE__, :records)
  end

  def restart do
    GenServer.call(__MODULE__, :restart)
  end

  @impl true
  def handle_call(:pointer, _from, state) do
    {:reply, {state.pointer, state.coincidences}, state}
  end

  @impl true
  def handle_call(:records, _from, state) do
    {:reply, state.records, state}
  end

  @impl true
  def handle_call(:restart, _from, _state) do
    new_state = %{
      coincidences: 0,
      pointer: 50,
      records: []
    }

    {:reply, :restarted, new_state}
  end

  @impl true
  def handle_cast(
        {:rotate, direction, number},
        %{pointer: pointer, coincidences: coincidences, records: records} = state
      ) do
    new_pointer =
      case direction do
        "L" ->
          result = pointer - number

          if result < 0 do
            result + 100
          else
            result
          end

        "R" ->
          result = pointer + number

          if result > 99 do
            result - 100
          else
            result
          end
      end

    coincidences =
      if new_pointer == 0 do
        coincidences + 1
      else
        coincidences
      end

    new_state = %{
      state
      | pointer: new_pointer,
        coincidences: coincidences,
        records: records ++ [{direction, number, pointer, new_pointer}]
    }

    {:noreply, new_state}
  end
end
