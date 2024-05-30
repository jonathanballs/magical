defmodule Magical.Parser.KvTest do
  use ExUnit.Case
  alias Magical.Parser.Kv

  test "parses a normal param/value pair" do
    assert Kv.parse("BEGIN:VCALENDAR") == {"begin", "VCALENDAR", %{}}

    # # Values are case sensitive - keys are not
    assert Kv.parse("begIN:VCALENDAR") == {"begin", "VCALENDAR", %{}}
    assert Kv.parse("BEGIN:vcalENDAR") == {"begin", "vcalENDAR", %{}}
  end

  test "parses params" do
    assert Kv.parse("NOTE;ENCODING=QUOTED-PRINTABLE:test value") ==
             {"note", "test value", %{"encoding" => "QUOTED-PRINTABLE"}}

    assert Kv.parse("ORGANIZER;CN=\"John Doe,Eng\":mailto:jd@some.com") ==
             {"organizer", "mailto:jd@some.com", %{"cn" => "John Doe,Eng"}}

    assert Kv.parse(
             "X-APPLE-STRUCTURED-LOCATION;VALUE=URI;X-ADDRESS=\"251 Tooley Street, London, SE1 2JX\";X-APPLE-RADIUS=49;X-TITLE=The King's Arms:geo:51.501568,-0.075906"
           ) ==
             {"x-apple-structured-location", "geo:51.501568,-0.075906",
              %{
                "value" => "URI",
                "x-address" => "251 Tooley Street, London, SE1 2JX",
                "x-apple-radius" => "49",
                "x-title" => "The King's Arms"
              }}
  end
end
