defmodule Magical.Serializer.EventSerializerTest do
  use ExUnit.Case
  alias Magical.Serializer.EventSerializer
  alias Magical.Event

  test "datetime fields" do
    assert """
           BEGIN:VEVENT
           DTEND:19980119T070000Z
           DTSTAMP:19980119T070000Z
           DTSTART:19980119T070000Z
           END:VEVENT
           """ =
             %Event{
               dtstart: ~U[1998-01-19 07:00:00Z],
               dtend: ~U[1998-01-19 07:00:00Z],
               dtstamp: ~U[1998-01-19 07:00:00Z]
             }
             |> EventSerializer.serialize()
  end

  test "date field" do
    assert """
           BEGIN:VEVENT
           DTEND;VALUE=DATE:19980119
           DTSTART;VALUE=DATE:19980119
           END:VEVENT
           """ =
             %Event{
               dtstart: ~D[1998-01-19],
               dtend: ~D[1998-01-19]
             }
             |> EventSerializer.serialize()
  end

  test "text fields" do
    assert """
           BEGIN:VEVENT
           LOCATION:London\\, England
           SUMMARY:My summary
           END:VEVENT
           """ =
             %Event{
               summary: "My summary",
               location: "London, England"
             }
             |> EventSerializer.serialize()
  end
end
