defmodule Magical.Parser.Kv do
  @moduledoc false
  # See: https://icalendar.org/iCalendar-RFC-5545/3-1-content-lines.html

  import NimbleParsec

  def parse(ical_line) do
    case parse_nimble(ical_line) do
      {:ok, parsed, _, _, _, _} ->
        Enum.reduce(parsed, {nil, nil, %{}}, fn
          {:name, [name]}, {_, value, params} ->
            {String.downcase(name), value, params}

          {:param, [param_name, param_value]}, {name, value, params} ->
            {name, value, Map.put(params, String.downcase(param_name), param_value)}

          {:value, [value]}, {name, _, params} ->
            {name, value, params}
        end)

      _error ->
        # dbg(ical_line)
        # dbg(error)
        nil
    end
  end

  name = empty() |> ascii_string([?a..?z, ?A..?Z, ?-], min: 1)
  value = empty() |> utf8_string(min: 1) |> tag(:value)

  # control_character = ascii_char([0x00..0x08, 0x0A..0x1F, 0x7F])

  safe_value = empty() |> ascii_string([not: ?", not: ?;, not: ?:, not: ?,], min: 1)

  qsafe_value = empty() |> utf8_string([not: ?"], min: 1)
  escaped_value = ignore(ascii_char([?"])) |> concat(qsafe_value) |> ignore(ascii_char([?"]))

  param =
    ignore(string(";"))
    |> concat(name)
    |> ignore(string("="))
    |> choice([safe_value, escaped_value])
    |> tag(:param)

  line = name |> tag(:name) |> repeat(param) |> ignore(string(":")) |> concat(value)

  defparsecp(:parse_nimble, line)
end
