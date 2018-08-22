# System06

## URB (Uniform Reliable Broadcast)
Validity, No Duplication and No Creation properties are the same as best effort broadcast and regular reliable broadcast.  If a process delivers message M then every correct process will also deliver M.  Implies a set of messages delivered by a faulty process is always a subset of messages delivered by a correct process (stronger guarantee).

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `system_06` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:system_06, "~> 0.1.0"}
  ]
end
```

## Program Running

(1) Type in `mix compile` to compile the file
(2) Next type in `iex -S mix` to start the program
(3) Type in `System06.main` to run the program


Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/system_06](https://hexdocs.pm/system_06).

## Note
In this repo there exists a subset of my work, often intentionally broken or misleading to avoid disrespectful people from copying and
pasting.
