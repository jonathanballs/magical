defmodule ICal.Parser do
  alias ICal.Calendar
  alias ICal.Event
  alias ICal.Parser.CalendarParser

  def parse_lines(lines) do
    lines
    |> build_tree()
    |> Enum.reduce(%Calendar{}, &CalendarParser.parse_calendar/2)
  end

  defp build_tree(lines) do
    {[tree], []} = build_tree([], lines)
    tree
  end

  @spec build_tree(List.t(), [{String.t(), String.t()}]) :: {List.t(), [{String.t(), String.t()}]}
  def build_tree(tree, [{"BEGIN", _value, _} = line | tail]) do
    {child_tree, tail} = build_tree([line], tail)
    build_tree([Enum.reverse(child_tree) | tree], tail)
  end

  def build_tree(tree, [{"END", _value, _} = line | tail]) do
    {[line | tree], tail}
  end

  def build_tree(tree, [keyval | tail]) do
    build_tree([keyval | tree], tail)
  end

  def build_tree(tree, []) do
    {tree, []}
  end
end
