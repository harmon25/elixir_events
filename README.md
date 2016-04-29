# ElixirEvents

A simple GenEvent tutorial to demonstrate the potential of OTP.

# Usage
Clone git repo 
```
cd elixir_events
#run tests
mix test
# launch shell, with ElixirEvents supervisor running
iex -S mix
```
# Example
```
EventEmitter.start_timer
EventEmitter.stop_timer

EventEmitter.send_event "Sweet message"

EventEmitter.emitted_events
EventHandler.recieved_events
```