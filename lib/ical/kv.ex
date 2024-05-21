defmodule ICal.Kv do
  def parse(ical_line) do
    case String.split(ical_line, ":", parts: 2) do
      [key, value] ->
        {key, params} = parse_key(key)
        {key, value, params}

      _ ->
        nil
    end
  end

  defp parse_key(key) do
    [key | params] = String.split(key, ";")
    {key, Enum.map(params, &String.split(&1, "=", parts: 2))}
  end
end
