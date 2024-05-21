defmodule ICalTest do
  use ExUnit.Case
  alias ICal.Fixtures

  test "greets the world" do
    "example.ics"
    |> Fixtures.load()
    |> ICal.parse()
    |> dbg()
  end
end
