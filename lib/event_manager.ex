defmodule EventManager do
  @moduledoc """
  EventManager, added to supervision tree used to manage event handlers.
  If this dies, handlers will die.
  Being supervised, it should stay alive, 
  handlers can be added again in start_link or init which are run when process is launched
  """

  @doc """
  Default function launched by supervisor.
  Returns pid of this process to monitor
  """
 def start_link() do
  {:ok, pid } = GenEvent.start_link(name: __MODULE__)
  GenEvent.add_handler(__MODULE__, EventHandler, [])
  {:ok, pid }
 end

  @doc """
  Add more event handlers
  This does not need to be done through a helper function can be called from anywhere passing the event managers Name/reference
  """
  def add_handler(handler) do
    GenEvent.add_handler(__MODULE__, handler, [])
  end
  
  @doc """
   Returns names of "installed" handlers
  """
  def current_handlers() do
    GenEvent.which_handlers(__MODULE__)
  end

end