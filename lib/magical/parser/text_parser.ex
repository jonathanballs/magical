defmodule Magical.Parser.TextParser do
  @moduledoc """
  Parser for https://icalendar.org/iCalendar-RFC-5545/3-3-11-text.html
  """
  import NimbleParsec

  def parse(text_string) do
    case nimble_parse(text_string) do
      {:ok, string, _, _, _, _} ->
        string
        |> Enum.map(&unescape_char/1)
        |> to_string()

      error ->
        dbg(error)
        text_string
    end
  end

  safe_char = utf8_char([])

  escaped_char =
    choice([
      string("\\\\"),
      string("\\;"),
      string("\\,"),
      string("\\n"),
      string("\\N")
    ])

  char = choice([escaped_char, safe_char])
  defparsecp(:nimble_parse, repeat(char) |> eos())

  defp unescape_char("\\\\"), do: "\\"
  defp unescape_char("\\;"), do: ";"
  defp unescape_char("\\,"), do: ","
  defp unescape_char("\\n"), do: "\n"
  defp unescape_char("\\N"), do: "\n"
  defp unescape_char(c), do: c
end
