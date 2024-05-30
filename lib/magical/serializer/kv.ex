defmodule Magical.Serializer.Kv do
  def serialize(name, value, params \\ %{}) do
    name =
      name
      |> Atom.to_string()
      |> String.replace("_", "-")
      |> String.upcase()

    "#{name}#{serialize_params(params)}:#{value}\n"
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
end
