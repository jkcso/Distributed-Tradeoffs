# System02

## RB (Reliable Broadcast)
For best-effort broadcast, if the sending process crashes during broadcast, then some arbitrary subset of processes will receive the message.  There is no delivery guarantee – processes do not agree on the delivery of the message.  With (regular) reliable broadcast all *correct* processes will agree on the messages they deliver, even if the broadcasting process crashes while sending.  If the broadcasting process crashes before any message is sent, then no message is delivered.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `system_02` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:system_02, "~> 0.1.0"}
  ]
end
```

## Program Running

(1) Type in `mix compile` to compile the file
(2) Next type in `iex -S mix` to start the program
(3) Type in `System02.main` to run the program

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/system_02](https://hexdocs.pm/system_02).
