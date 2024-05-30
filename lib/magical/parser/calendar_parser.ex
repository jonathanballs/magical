defmodule Magical.Parser.CalendarParser do
  @moduledoc false

  alias Magical.Parser.TextParser
  alias Magical.Calendar
  alias Magical.Parser.EventParser

  def parse(lines) do
    Enum.reduce(lines, %Calendar{}, &parse_calendar/2)
  end

  defp parse_calendar([{"begin", "VEVENT", _} | _] = event, calendar) do
    child = EventParser.parse(event)
    %{calendar | events: [child | calendar.events]}
  end

  defp parse_calendar({"version", version, _}, calendar),
    do: Map.put(calendar, :version, TextParser.parse(version))

  defp parse_calendar({"x-wr-timezone", time_zone, _}, calendar),
    do: Map.put(calendar, :time_zone, TextParser.parse(time_zone))

  defp parse_calendar({"prodid", prodid, _}, calendar),
    do: Map.put(calendar, :prodid, TextParser.parse(prodid))

  defp parse_calendar({"x-wr-calname", calname, _}, calendar),
    do: Map.put(calendar, :name, TextParser.parse(calname))

  defp parse_calendar({"x-name", name, _}, calendar),
    do: Map.put(calendar, :name, TextParser.parse(name))

  # RFC-7986 5.1
  defp parse_calendar({"name", name, _}, calendar),
    do: Map.put(calendar, :name, TextParser.parse(name))

  defp parse_calendar({"x-wr-caldesc", caldesc, _}, calendar),
    do: Map.put(calendar, :description, TextParser.parse(caldesc))

  # RFC-7986 5.2
  defp parse_calendar({"description", caldesc, _}, calendar),
    do: Map.put(calendar, :description, TextParser.parse(caldesc))

  defp parse_calendar(_, calendar), do: calendar
end
