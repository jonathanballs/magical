defmodule Magical.Parser.CalendarParser do
  alias Magical.Event
  alias Magical.Parser.EventParser

  def parse_calendar([{"begin", "VEVENT", _} | _] = event, calendar) do
    child = Enum.reduce(event, %Event{}, &EventParser.parse_event/2)
    %{calendar | events: [child | calendar.events]}
  end

  def parse_calendar({"version", version, _}, calendar), do: Map.put(calendar, :version, version)

  def parse_calendar({"x-wr-timezone", time_zone, _}, calendar),
    do: Map.put(calendar, :time_zone, time_zone)

  def parse_calendar({"prodid", prodid, _}, calendar), do: Map.put(calendar, :prodid, prodid)

  def parse_calendar({"x-wr-calname", calname, _}, calendar),
    do: Map.put(calendar, :title, calname)

  def parse_calendar({"x-name", name, _}, calendar),
    do: Map.put(calendar, :title, name)

  def parse_calendar({"name", name, _}, calendar),
    do: Map.put(calendar, :title, name)

  def parse_calendar({"x-wr-caldesc", caldesc, _}, calendar),
    do: Map.put(calendar, :title, caldesc)

  def parse_calendar(_, calendar), do: calendar
end
