defmodule ICal.Parser.DateParserTest do
  use ExUnit.Case
  alias ICal.Parser.DateParser

  test "parsing" do
    # Standard date time
    assert DateParser.parse("19980119T070000Z") == ~U[1998-01-19 07:00:00Z]

    # Naive date time
    assert DateParser.parse("19980119T070000") == ~N[1998-01-19 07:00:00]

    # Date
    assert DateParser.parse("19980119") == ~D[1998-01-19]

    # Leap second
    assert DateParser.parse("19970630T235960Z") == ~U[1997-07-01 00:00:00Z]
  end
end
