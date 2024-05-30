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
end
