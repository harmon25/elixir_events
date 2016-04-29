# ElixirEvents

A simple GenEvent tutorial to demonstrate the potential of OTP.

# Usage
Clone git repo 
```sh
cd elixir_events
# run tests
mix test
# launch shell, with ElixirEvents supervisor running
iex -S mix
```
# Example
```elixir
iex> EventEmitter.start_timer
iex> EventEmitter.stop_timer

iex> EventEmitter.send_event "Sweet message"

iex> EventEmitter.emitted_events
iex> EventHandler.received_events
```