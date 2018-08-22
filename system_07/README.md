# System07

## URB (Majority-Ack Uniform Reliable Broadcast)
(URB) Deliver message only after the message has been beb-delivered by a majority (quorum) of processes.  The majority contains at least one correct process.  Fail-silent algorithm where process crashes are not reliably detected.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `system_07` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:System07, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/system_07](https://hexdocs.pm/lazy).
