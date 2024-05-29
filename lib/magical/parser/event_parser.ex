defmodule Magical.Parser.EventParser do
  @moduledoc false

  alias Magical.Event
  alias Magical.Parser.DateParser

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

  defp parse_event({field, value, _}, event) do
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
