defmodule Magical.Parser.CalendarParser do
  @moduledoc false

  alias Magical.Calendar
  alias Magical.Event
  alias Magical.Parser.EventParser

  def parse(lines) do
    Enum.reduce(lines, %Calendar{}, &parse_calendar/2)
  end

  def parse_calendar([{"begin", "VEVENT", _} | _] = event, calendar) do
    child = Enum.reduce(event, %Event{}, &EventParser.parse_event/2)
    %{calendar | events: [child | calendar.events]}
  end

  def parse_calendar({"version", version, _}, calendar), do: Map.put(calendar, :version, version)

  def parse_calendar({"x-wr-timezone", time_zone, _}, calendar),
    do: Map.put(calendar, :time_zone, time_zone)

  def parse_calendar({"prodid", prodid, _}, calendar), do: Map.put(calendar, :prodid, prodid)

  def parse_calendar({"x-wr-calname", calname, _}, calendar),
    do: Map.put(calendar, :name, calname)

  def parse_calendar({"x-name", name, _}, calendar),
    do: Map.put(calendar, :name, name)

  # RFC-7986 5.1
  def parse_calendar({"name", name, _}, calendar),
    do: Map.put(calendar, :name, name)

  def parse_calendar({"x-wr-caldesc", caldesc, _}, calendar),
    do: Map.put(calendar, :description, caldesc)

  # RFC-7986 5.2
  def parse_calendar({"description", caldesc, _}, calendar),
    do: Map.put(calendar, :description, caldesc)

  def parse_calendar(_, calendar), do: calendar
end
