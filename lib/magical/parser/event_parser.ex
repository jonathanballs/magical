defmodule Magical.Parser.EventParser do
  @moduledoc false

  alias Magical.Parser.DateParser

  @spec parse_event({String.t(), String.t(), String.t()}, Event.t()) :: Event.t()
  def parse_event({"dtstart", dtstart, args}, event) do
    Map.put(event, :dtstart, parse_date(dtstart, args))
  end

  def parse_event({"dtend", dtend, args}, event) do
    Map.put(event, :dtend, parse_date(dtend, args))
  end

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

  def parse_date(date, %{"tzid" => time_zone}) do
    case DateParser.parse(date) do
      %NaiveDateTime{} = ndt ->
        {:ok, dt} = DateTime.from_naive(ndt, time_zone)
        dt

      dt ->
        dt
    end
  end

  def parse_date(date, _) do
    DateParser.parse(date)
  end
end
