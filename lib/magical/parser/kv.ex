defmodule Magical.Parser.Kv do
  @moduledoc false

  def parse(ical_line) do
    case String.split(ical_line, ":", parts: 2) do
      [key, value] ->
        {key, params} = parse_key(key)
        {String.downcase(key), value, params}

      _ ->
        nil
    end
  end

  defp parse_key(key) do
    [key | params] = String.split(key, ";")

    params =
      params
      |> Enum.map(&String.split(&1, "=", parts: 2))
      |> Enum.map(fn
        [key, val] -> {String.downcase(key), val}
        _ -> nil
      end)
      |> Enum.filter(fn n -> not is_nil(n) end)
      |> Enum.into(%{})

    {key, params}
  end
end
