defmodule Magical.Serializer.EventSerializer do
  alias Magical.Serializer.DateSerializer
  alias Magical.Serializer.TextSerializer
  alias Magical.Event
  alias Magical.Serializer.KvSerializer

  def serialize(%Event{} = event) do
    content =
      event
      |> Map.from_struct()
      |> Enum.reject(fn {_, v} -> is_nil(v) end)
      # Sort by key to ensure generation is reproducible. Apple does this.
      |> Enum.sort_by(fn {k, _} -> Atom.to_string(k) end)
      |> Enum.map(&do_serialize/1)
      |> Enum.join("")

    """
    BEGIN:VEVENT
    #{content}END:VEVENT
    """
  end

  @datetime_fields [:dtstart, :dtend, :dtstamp, :last_modified, :created]

  @datetime_fields
  |> Enum.each(fn field ->
    def do_serialize({unquote(field), value}) do
      {val, params} = DateSerializer.serialize(value)
      KvSerializer.serialize(unquote(field), val, params)
    end
  end)

  def do_serialize({field_name, field_value}) do
    KvSerializer.serialize(field_name, TextSerializer.serialize(field_value))
  end
end
