defmodule EventEmitter do
  use GenServer
  @moduledoc """
  Simple GenServer that emits messages for the event Manager
  """

  # GenServer Server API
  def start_link() do
    GenServer.start_link(__MODULE__, %{emitted_events: 0, timer: nil}, name: __MODULE__)
  end

  def init(emitter_state) do
    IO.puts "EventEmitter initalized!"
    {:ok, emitter_state }
  end

  def handle_cast({:event, msg}, emitter_state) do
    events_count = emitter_state.emitted_events + 1
    GenEvent.notify(EventManager, {:eventA, msg})
    {:noreply, %{emitter_state | emitted_events: events_count}}
  end

  def handle_cast(:start, emitter_state) do
    IO.puts "starting event timer"
    {:ok, timer_process} = :timer.send_interval(10000, self(), :interval)
    {:noreply, %{emitter_state | timer: timer_process}}
  end

  def handle_cast(:stop, emitter_state) do
    IO.puts "stopping event timer"
    {:ok, :cancel} = :timer.cancel(emitter_state.timer)
    {:noreply, %{emitter_state | timer: nil}}
  end

  def handle_call(:events, _from, emitter_state) do
    {:reply, emitter_state.emitted_events, emitter_state}
  end

   def handle_info(:interval, emitter_state) do
    events_count = emitter_state.emitted_events + 1
    GenEvent.notify(EventManager, :eventB)
    {:noreply, %{emitter_state | emitted_events: events_count}}
   end

 # GenServer Client API

  @doc """
    Send an event to the event manager
  """
  def send_event(msg) do
    GenServer.cast(__MODULE__, {:event, msg})
  end

  @doc """
    Return number of emitted events
  """
  def emitted_events() do
    GenServer.call(__MODULE__, :events)
  end

  @doc """
    Stop auto event emitter timer
  """
  def stop_timer() do
    GenServer.cast(__MODULE__, :stop)
  end

  @doc """
    Start auto event emitter timer
    Sends message to this process every 10 seconds, will trigger an event
    This could be communication from the outside world
  """
  def start_timer() do
    GenServer.cast(__MODULE__, :start)
  end

end