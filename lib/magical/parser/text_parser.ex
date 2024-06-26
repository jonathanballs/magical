defmodule Magical.Parser.TextParser do
  @moduledoc """
  Parser for https://icalendar.org/iCalendar-RFC-5545/3-3-11-text.html
  """
  import NimbleParsec

  def parse(text_string) do
    # This can't really fail because any string could just be string of
    # utf8_char if the original generator refused to escape anything.
    {:ok, string, _, _, _, _} = nimble_parse(text_string)

    string
    |> Enum.map(&unescape_char/1)
    |> to_string()
  end

  escaped_char =
    choice([
      string("\\\\"),
      string("\\;"),
      string("\\,"),
      string("\\n"),
      string("\\N")
    ])

  char = choice([escaped_char, utf8_char([])])
  defparsecp(:nimble_parse, repeat(char) |> eos())

  defp unescape_char("\\\\"), do: "\\"
  defp unescape_char("\\;"), do: ";"
  defp unescape_char("\\,"), do: ","
  defp unescape_char("\\n"), do: "\n"
  defp unescape_char("\\N"), do: "\n"
  defp unescape_char(c), do: c
end
