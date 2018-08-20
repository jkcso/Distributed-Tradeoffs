defmodule System07LazyTest do
  use ExUnit.Case
  doctest System07Lazy

  test "greets the world" do
    assert System07Lazy.hello() == :world
  end
end
