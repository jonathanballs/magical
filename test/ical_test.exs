defmodule IcalTest do
  use ExUnit.Case
  doctest Ical

  test "greets the world" do
    assert Ical.hello() == :world
  end
end
