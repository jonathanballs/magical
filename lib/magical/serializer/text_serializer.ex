defmodule Magical.Serializer.TextSerializer do
  def serialize(text_string) do
    text_string
    |> String.codepoints()
    |> Enum.map(&escape_char/1)
    |> Enum.join("")
  end

  defp escape_char("\n"), do: ~S(\n)
  defp escape_char(","), do: ~S(\,)
  defp escape_char(";"), do: ~S(\;)
  defp escape_char("\\"), do: "\\\\"
  defp escape_char(c), do: c
end
