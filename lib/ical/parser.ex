defmodule ICal.Parser do
  alias ICal.Calendar
  alias ICal.Parser.CalendarParser

  def parse(ical_string) do
    ical_string
    |> adjust_wrapped_lines()
    |> String.split("\n")
    |> Enum.map(&String.trim_trailing/1)
    |> Enum.map(&String.replace(&1, ~S"\n", "\n"))
    |> Enum.map(&ICal.Kv.parse/1)
    |> Enum.filter(fn l -> not is_nil(l) end)
    |> parse_lines()
  end

  defp adjust_wrapped_lines(body) do
    String.replace(body, ~r/\r?\n[ \t]/, "")
  end

  defp parse_lines(lines) do
    lines
    |> build_tree()
    |> Enum.reduce(%Calendar{}, &CalendarParser.parse_calendar/2)
  end

  defp build_tree(lines) do
    {[tree], []} = build_tree([], lines)
    tree
  end

  @spec build_tree(List.t(), [{String.t(), String.t()}]) :: {List.t(), [{String.t(), String.t()}]}
  def build_tree(tree, [{"begin", _value, _} = line | tail]) do
    {child_tree, tail} = build_tree([line], tail)
    build_tree([Enum.reverse(child_tree) | tree], tail)
  end

  def build_tree(tree, [{"end", _value, _} = line | tail]) do
    {[line | tree], tail}
  end

  def build_tree(tree, [keyval | tail]) do
    build_tree([keyval | tree], tail)
  end

  def build_tree(tree, []) do
    {tree, []}
  end
end
