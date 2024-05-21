defmodule Magical.Parser.EventParser do
  alias Magical.Parser.DateParser

  @spec parse_event({String.t(), String.t(), String.t()}, Event.t()) :: Event.t()
  def parse_event({"dtstart", dtstart, _}, event),
    do: Map.put(event, :dtstart, DateParser.parse(dtstart))

  def parse_event({"dtend", dtend, _}, event),
    do: Map.put(event, :dtend, DateParser.parse(dtend))

  def parse_event({"dtstamp", dtstamp, _}, event),
    do: Map.put(event, :dtstamp, DateParser.parse(dtstamp))

  def parse_event({field, value, _}, event) do
    keys =
      Magical.Event.__struct__()
      |> Map.keys()
      |> Enum.filter(fn k -> k != :__struct__ end)
      |> Enum.map(&to_string/1)

    case Enum.member?(keys, field) do
      true -> Map.put(event, String.to_atom(field), value)
      false -> event
    end
  end
end
