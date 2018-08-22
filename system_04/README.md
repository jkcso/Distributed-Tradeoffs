# System04

## RB (Lazy Reliable broadcast)
Uses best-effort-broadcast, but includes a failure detector component to detect processes that have failed (stopped).  Agreement is derived from (i) the validity property of BEB, (ii) that every correct process forwards every message it delivers when it detects a crashed process and (iii) the properties of PFD. Other properties are as for the Eager RB algorithm.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `system_04` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:system_04, "~> 0.1.0"}
  ]
end
```

## Program Running

(1) Type in `mix compile` to compile the file
(2) Next type in `iex -S mix` to start the program
(3) Type in `System04.main` to run the program

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/system_03](https://hexdocs.pm/system_03).
