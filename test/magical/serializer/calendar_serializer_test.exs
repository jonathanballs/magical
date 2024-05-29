defmodule Magical.Serializer.CalendarSerializerTest do
  alias Magical.Calendar
  alias Magical.Serializer.CalendarSerializer

  use ExUnit.Case

  test "respects calendar name, description and time zone" do
    assert """
           BEGIN:VCALENDAR
           VERSION:2.0
           METHOD:PUBLISH
           PRODID://Magical//EN
           CALSCALE:GREGORIAN
           X-WR-CALNAME:Test name
           X-WR-CALDESC:Test description
           X-WR-TIMEZONE:Europe/Paris
           END:VCALENDAR
           """ =
             %Calendar{
               name: "Test name",
               description: "Test description",
               time_zone: "Europe/Paris"
             }
             |> CalendarSerializer.serialize()
  end
end
