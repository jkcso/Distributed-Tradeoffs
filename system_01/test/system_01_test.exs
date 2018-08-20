defmodule System01Test do
  use ExUnit.Case
  doctest System01

  test "greets the world" do
    assert System01.hello() == :world
  end
end
