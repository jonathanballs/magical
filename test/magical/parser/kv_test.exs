defmodule Magical.Parser.KvTest do
  use ExUnit.Case
  alias Magical.Parser.Kv

  test "parses a normal param/value pair" do
    assert Kv.parse("BEGIN:VCALENDAR") == {"begin", "VCALENDAR", %{}}

    # Values are case sensitive - keys are not
    assert Kv.parse("begIN:VCALENDAR") == {"begin", "VCALENDAR", %{}}
    assert Kv.parse("BEGIN:vcalENDAR") == {"begin", "vcalENDAR", %{}}
  end

  test "parses params" do
    assert Kv.parse("NOTE;ENCODING=QUOTED-PRINTABLE:test value") ==
             {"note", "test value", %{"encoding" => "QUOTED-PRINTABLE"}}

    assert Kv.parse("ORGANIZER;CN=\"John Doe,Eng\":mailto:jd@some.com") ==
             {"organizer", "mailto:jd@some.com", %{"cn" => "John Doe,Eng"}}
  end
end
