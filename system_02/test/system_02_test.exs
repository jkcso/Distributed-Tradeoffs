defmodule System02Test do
  use ExUnit.Case
  doctest System02

  test "greets the world" do
    assert System02.hello() == :world
  end
end
