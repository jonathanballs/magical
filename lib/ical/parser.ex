defmodule Magical.Parser do
  @moduledoc false

  alias Magical.Event
  alias Magical.Calendar
  alias Magical.Parser.CalendarParser

  def parse(ical_string) do
    ical_string
    |> prepare_lines()
    |> Enum.map(&Magical.Kv.parse/1)
    |> case do
      [{"begin", "VCALENDAR", _} | _tail] = content ->
        calendar =
          content
          |> Enum.filter(fn l -> not is_nil(l) end)
          |> build_tree()
          |> Enum.reduce(%Calendar{}, &CalendarParser.parse_calendar/2)
          |> resolve_time_zones()

        {:ok, calendar}

      _ ->
        {:error, :invalid}
    end
  end

  defp prepare_lines(lines) do
    lines
    |> adjust_wrapped_lines()
    |> String.split("\n")
    |> Enum.map(&String.trim_trailing/1)
    |> Enum.map(&String.replace(&1, ~S"\n", "\n"))
  end

  defp adjust_wrapped_lines(body) do
    String.replace(body, ~r/\r?\n[ \t]/, "")
  end

  defp build_tree(lines) do
    {[tree], []} = build_tree([], lines)
    tree
  end

  @spec build_tree(List.t(), [{String.t(), String.t()}]) :: {List.t(), [{String.t(), String.t()}]}
  defp build_tree(tree, [{"begin", _value, _} = line | tail]) do
    {child_tree, tail} = build_tree([line], tail)
    build_tree([Enum.reverse(child_tree) | tree], tail)
  end

  defp build_tree(tree, [{"end", _value, _} = line | tail]) do
    {[line | tree], tail}
  end

  defp build_tree(tree, [keyval | tail]) do
    build_tree([keyval | tree], tail)
  end

  defp build_tree(tree, []) do
    {tree, []}
  end

  defp resolve_time_zones(%Calendar{time_zone: time_zone, events: events} = calendar) do
    case DateTime.now(time_zone) do
      {:ok, _time} ->
        %{calendar | events: Enum.map(events, &resolve_time_zones(&1, time_zone))}

      {:error, _} ->
        resolve_time_zones(%{calendar | time_zone: "Etc/UTC"})
    end
  end

  defp resolve_time_zones(%Event{dtstart: dtstart, dtend: dtend} = event, time_zone) do
    %{
      event
      | dtstart: resolve_time_zones(dtstart, time_zone),
        dtend: resolve_time_zones(dtend, time_zone)
    }
  end

  defp resolve_time_zones(%NaiveDateTime{} = naive_date_time, time_zone) do
    case DateTime.from_naive(naive_date_time, time_zone) do
      {:ok, date_time} -> date_time
      {:error, _} -> resolve_time_zones(naive_date_time, "Etc/UTC")
    end
  end

  defp resolve_time_zones(%Date{} = date, _time_zone), do: date
  defp resolve_time_zones(%DateTime{} = date_time, _time_zone), do: date_time
end
