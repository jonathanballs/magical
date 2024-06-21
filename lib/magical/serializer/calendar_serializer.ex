defmodule Magical.Serializer.CalendarSerializer do
  alias Magical.Calendar

  alias Magical.Serializer.EventSerializer
  alias Magical.Serializer.KvSerializer

  @defaults %{
    version: "2.0",
    calscale: "GREGORIAN",
    prodid: "//Magical//Magical//EN"
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

  defp do_serialize(%{version: version} = calendar) do
    KvSerializer.serialize(:version, version) <> do_serialize(Map.delete(calendar, :version))
  end

  defp do_serialize(%{method: method} = calendar) do
    KvSerializer.serialize(:method, method) <> do_serialize(Map.delete(calendar, :method))
  end

  defp do_serialize(%{prodid: prodid} = calendar) do
    KvSerializer.serialize(:prodid, prodid) <> do_serialize(Map.delete(calendar, :prodid))
  end

  defp do_serialize(%{calscale: calscale} = calendar) do
    KvSerializer.serialize(:calscale, calscale) <> do_serialize(Map.delete(calendar, :calscale))
  end

  defp do_serialize(%{name: name} = calendar) do
    KvSerializer.serialize(:"X-WR-CALNAME", name) <> do_serialize(Map.delete(calendar, :name))
  end

  defp do_serialize(%{description: description} = calendar) do
    KvSerializer.serialize(:"X-WR-CALDESC", description) <>
      do_serialize(Map.delete(calendar, :description))
  end

  defp do_serialize(%{time_zone: time_zone} = calendar) do
    KvSerializer.serialize(:"X-WR-TIMEZONE", time_zone) <>
      do_serialize(Map.delete(calendar, :time_zone))
  end

  defp do_serialize(%{events: events}) do
    events
    |> Enum.map(&EventSerializer.serialize/1)
    |> Enum.join("")
  end
end
