defmodule EventHandler do
  @moduledoc """
    Simple EventHandler - just logs events
    This could relay messages to other processes to perform further action when events occur
    Handlers can have their own state, must be in a list []
    This example is stateless.
  """

  use GenEvent
  require Logger


  def init(_args) do
    IO.puts "EventHandler initalized!"
    {:ok, [{:events, 0}]}
  end

  @doc """
    Handle eventB, with a message
  """
  def handle_event({:eventA, msgA}, [{:events, num_events}]) do
    new_num_events = num_events + 1
   Logger.info("eventA received: #{inspect msgA}")
   {:ok, [{:events, new_num_events}]}
  end

  @doc """
    Handle eventB, without a message
  """
  def handle_event(:eventB, [{:events, num_events}]) do
     new_num_events = num_events + 1
    Logger.info("eventB received!")
    {:ok, [{:events, new_num_events}]}
  end

  def handle_call(:received_events, [{:events, num_events}]) do
    {:ok, num_events, [{:events, num_events}]}
  end

  def recieved_events() do
    GenEvent.call(EventManager, __MODULE__, :received_events)
  end

end