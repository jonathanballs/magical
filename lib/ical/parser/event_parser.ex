defmodule ICal.Parser.EventParser do
  alias ICal.Parser.DateParser

  @spec parse_event({String.t(), String.t(), String.t()}, Event.t()) :: Event.t()
  def parse_event({"LOCATION", location, _}, event), do: Map.put(event, :location, location)

  def parse_event({"SUMMARY", summary, _}, event), do: Map.put(event, :summary, summary)

  def parse_event({"DESCRIPTION", description, _}, event),
    do: Map.put(event, :description, description)

  def parse_event({"DTSTART", start, _}, event),
    do: Map.put(event, :start, DateParser.parse(start))

  def parse_event({"DTEND", end_, _}, event),
    do: Map.put(event, :end, DateParser.parse(end_))

  def parse_event(_, event), do: event
end
