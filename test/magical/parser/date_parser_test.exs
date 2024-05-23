defmodule Magical.Parser.DateParserTest do
  use ExUnit.Case
  alias Magical.Parser.DateParser

  test "String parsing" do
    # Standard date time
    assert DateParser.parse("19980119T070000Z") == ~U[1998-01-19 07:00:00Z]
    assert DateParser.parse("19985019T070000Z") == nil

    # Naive date time
    assert DateParser.parse("19980119T070000") == ~N[1998-01-19 07:00:00]
    assert DateParser.parse("19985019T070000") == nil

    # Date
    assert DateParser.parse("19980119") == ~D[1998-01-19]

    # Leap second
    assert DateParser.parse("19970630T235960Z") == ~U[1997-07-01 00:00:00Z]

    # Invalid date
    assert DateParser.parse("random_string_that_is_invalid") == nil
  end

  test "tzid" do
    # tzid with a naive_datetime
    {:ok, date_time} = DateTime.from_naive(~N[1998-01-19 07:00:00], "Asia/Bangkok")
    assert DateParser.parse("19980119T070000", %{"tzid" => "Asia/Bangkok"}) == date_time
    assert DateParser.parse("19980119T070000", %{"tzid" => "Invalid/Timezone"}) == nil

    # tzid with UTC date_time is ignored
    assert DateParser.parse("19980119T070000Z", %{"tzid" => "Asia/Bangkok"}) ==
             ~U[1998-01-19 07:00:00Z]

    # tzid with UTC date is ignored
    assert DateParser.parse("19980119", %{"tzid" => "Asia/Bangkok"}) == ~D[1998-01-19]
  end

  test "value" do
    # date with value=date-time
    assert DateParser.parse("19980119", %{"value" => "DATE-TIME"}) == ~N[1998-01-19T00:00:00]

    # date with value=date
    assert DateParser.parse("19980119", %{"value" => "DATE"}) == ~D[1998-01-19]

    # naive_date_time with value=date-time
    assert DateParser.parse("19980119T070000", %{"value" => "DATE-TIME"}) ==
             ~N[1998-01-19T07:00:00]

    # date_time with value=date-time
    assert DateParser.parse("19980119T070000Z", %{"value" => "DATE-TIME"}) ==
             ~U[1998-01-19T07:00:00Z]

    # date_time with value=date
    assert DateParser.parse("19980119T070000Z", %{"value" => "DATE"}) ==
             ~D[1998-01-19]

    assert DateParser.parse("19980119T070000", %{"value" => "DATE"}) ==
             ~D[1998-01-19]
  end
end
