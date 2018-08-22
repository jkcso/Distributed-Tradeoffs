# System01

## BEB (Best Effort Broadcast)
Given a list of all processes and a message, a process could send the message to all processes (including itself) with multiple sends, something like:

`for p <- processes, do: send p, message`

Sender does not know which processes received the message.  We'll assume (i) messages are unique (e.g. include process-id+seq-no), (ii) no process broadcasts a message twice, (ii) no two processes ever broadcast the same message.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `system_01` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:system_01, "~> 0.1.0"}
  ]
end
```
## Program Running

(1) Type in `mix compile` to compile the file
(2) Next type in `iex -S mix` to start the program
(3) Type in `System01.main` to run the program

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/system_01](https://hexdocs.pm/system_01).

## Note
In this repo there exists a subset of my work, often intentionally broken or misleading to avoid disrespectful people from copying and
pasting.
