# System05

## PFD (Perfect failure detector)
Provides processes with a list of suspected processes (detected processes) that have crashed.  Makes timing assumptions (assumes systems are not asynchronous).  Never changes its view – suspected processes remain suspected forever.  Uses PL to exchange heartbeat messages plus a timeout mechanism (Recall PL performs reliable sending for correct processes).  Delay for timeout needs to be large enough for sending to all processes, processing at receiving processes and all replies back.  After a timeout, any process from which a reply has not been received is considered crashed, even it is alive and the reply message arrived after the timeout.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `system_05` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:system_05, "~> 0.1.0"}
  ]
end
```

## Program Running

(1) Type in `mix compile` to compile the file
(2) Next type in `iex -S mix` to start the program
(3) Type in `System05.main` to run the program

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/system_03](https://hexdocs.pm/system_03).

## Note
In this repo there exists a subset of my work, often intentionally broken or misleading to avoid disrespectful people from copying and
pasting.
