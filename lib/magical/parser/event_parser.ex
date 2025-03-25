defmodule Magical.Parser.EventParser do
  @moduledoc false

  alias Magical.Event
  alias Magical.Parser.TextParser
  alias Magical.Parser.DateParser
  alias Magical.Parser.AlarmParser

  def parse(lines) do
    Enum.reduce(lines, %Event{}, &parse_event/2)
  end

  @spec parse_event({String.t(), String.t(), String.t()}, Event.t()) :: Event.t()
  defp parse_event({"dtstart", dtstart, args}, event) do
    Map.put(event, :dtstart, DateParser.parse(dtstart, args))
  end

  defp parse_event({"dtend", dtend, args}, event) do
    Map.put(event, :dtend, DateParser.parse(dtend, args))
  end

  defp parse_event({"dtstamp", dtstamp, _}, event),
    do: Map.put(event, :dtstamp, DateParser.parse(dtstamp, %{}))

  defp parse_event({"last-modified", last_modified, _}, event),
    do: Map.put(event, :last_modified, DateParser.parse(last_modified, %{}))

  defp parse_event({"created", created, _}, event),
    do: Map.put(event, :created, DateParser.parse(created, %{}))

  defp parse_event([{"begin", "VALARM", _} | alarm], event),
    do: Map.put(event, :alarm, AlarmParser.parse(alarm))

  defp parse_event({field, value, _}, event) do
    keys =
      Magical.Event.__struct__()
      |> Map.keys()
      |> Enum.filter(fn k -> k != :__struct__ end)
      |> Enum.map(&to_string/1)

    case Enum.member?(keys, field) do
      true ->
        Map.put(event, String.to_atom(field), TextParser.parse(value))

      false ->
        event
    end
  end
end
