defmodule ShoppingList do
    use GenServer # bring in GenServer module

    #Client
    def start_link() do

      GenServer.start_link(__MODULE__, []) #__MODULE__ returns our shopping list module, next parameter passes in any inital state to start in
    end

    def add(pid, item) do
      GenServer.cast(pid, item)
    end

    def view(pid) do
      GenServer.call(pid, :view)
    end

    def remove(pid, item) do
      GenServer.cast(pid, {:remove, item})
    end

    def stop(pid) do
      GenServer.stop(pid, :normal, :infinity)
    end

    # once we call GenServer.start_link(), the 'init' callback is triggered so we need to define it
    #Server
    def init(list) do # takes in the initial state of an empty list included as the 2nd arg in start_link
      # init has a specific format that it needs to return
      {:ok, list}
    end

    def handle_cast({:remove, item}, list) do
      updated_list = Enum.reject(list, fn(i) -> i == item end)
      {:noreply, updated_list}
    end

    def handle_cast(item, list) do
      updated_list = [item|list]
      {:noreply, updated_list}
    end

    def handle_call(:view, _from, list) do
      {:reply, list, list}
    end

    def terminate(_reason, list) do
      IO.puts("We are all done shopping.")
      IO.inspect(list)
      :ok
    end




end
