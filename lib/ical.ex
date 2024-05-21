defmodule ICal do
  @moduledoc """
  Documentation for `Ical`.
  """

  alias ICal.Parser

  def parse(ical_string) do
    ical_string
    |> adjust_wrapped_lines()
    |> String.split("\n")
    |> Enum.map(&String.trim_trailing/1)
    |> Enum.map(&String.replace(&1, ~S"\n", "\n"))
    |> Enum.map(&ICal.Kv.parse/1)
    |> Enum.filter(fn l -> not is_nil(l) end)
    |> Parser.parse_lines()
  end

  defp adjust_wrapped_lines(body) do
    String.replace(body, ~r/\r?\n[ \t]/, "")
  end
end
