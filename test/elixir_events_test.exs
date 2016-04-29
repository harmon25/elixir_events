defmodule ElixirEventsTest do
  use ExUnit.Case
  doctest ElixirEvents

  test "Events work!" do
    #send 3 events
    EventEmitter.send_event("Message 1")
    EventEmitter.send_event("Message 2")
    EventEmitter.send_event("Message 3")

    # make sure events have been recieved
    assert EventEmitter.emitted_events == EventHandler.recieved_events
  end
  
end
