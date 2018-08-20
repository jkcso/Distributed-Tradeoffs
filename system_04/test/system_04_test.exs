defmodule System04Test do
  use ExUnit.Case
  doctest system04

  test "greets the world" do
    assert System04.hello() == :world
  end
end
