defmodule Magical.Serializer.CalendarSerializer do
  alias Magical.Calendar

  @defaults %{
    version: "2.0",
    calscale: "GREGORIAN",
    prodid: "//Magical//EN",
    method: "PUBLISH"
  }

  def serialize(%Calendar{} = calendar) do
    content =
      calendar
      |> Map.from_struct()
      |> Enum.reject(fn {_, v} -> is_nil(v) end)
      |> Enum.into(%{})
      |> (&Map.merge(@defaults, &1)).()
      |> do_serialize()

    """
    BEGIN:VCALENDAR
    #{content}END:VCALENDAR
    """
  end

  defp do_serialize(%{method: method} = calendar) do
    "METHOD:#{method}\n" <> do_serialize(Map.delete(calendar, :method))
  end

  defp do_serialize(%{prodid: prodid} = calendar) do
    "PRODID:#{prodid}\n" <> do_serialize(Map.delete(calendar, :prodid))
  end

  defp do_serialize(%{calscale: calscale} = calendar) do
    "CALSCALE:#{calscale}\n" <> do_serialize(Map.delete(calendar, :calscale))
  end

  defp do_serialize(%{}) do
    ""
  end
end
