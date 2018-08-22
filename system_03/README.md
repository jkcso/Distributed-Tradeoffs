# System03

## RB (Eager Reliable Broadcast)
Every process re-broadcasts every message it delivers.  If the broadcasting process crashes, the message will be forwarded by other processes using best-effort-broadcast.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `system_03` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:system_03, "~> 0.1.0"}
  ]
end
```

## Program Running

(1) Type in `mix compile` to compile the file
(2) Next type in `iex -S mix` to start the program
(3) Type in `System03.main` to run the program

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/system_03](https://hexdocs.pm/system_03).

## Note
In this repo there exists a subset of my work, often intentionally broken or misleading to avoid disrespectful people from copying and
pasting.
