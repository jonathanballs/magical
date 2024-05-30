defmodule Magical.Serializer.KvSerializer do
  @max_line_length 75

  def serialize(name, value, params \\ %{}) do
    name =
      name
      |> Atom.to_string()
      |> String.replace("_", "-")
      |> String.upcase()

    wrap("#{name}#{serialize_params(params)}:#{value}") <> "\n"
  end

  defp serialize_params(params) do
    params
    |> Enum.map(fn {key, value} ->
      key =
        key
        |> Atom.to_string()
        |> String.upcase()

      ";#{key}=#{value}"
    end)
    |> Enum.join("")
  end

  defp wrap(text_string) do
    {first_line, tail} =
      text_string
      |> String.codepoints()
      |> Enum.split(@max_line_length)

    tail =
      tail
      |> Enum.chunk_every(@max_line_length - 1)
      |> Enum.map(&Enum.join(&1, ""))

    first_line = Enum.join(first_line, "")

    [first_line | tail]
    |> Enum.join("\n ")
  end
end
