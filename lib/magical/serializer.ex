defmodule Magical.Serializer do
  alias Magical.Serializer.CalendarSerializer

  def serialize(%Magical.Calendar{} = calendar) do
    CalendarSerializer.serialize(calendar)
  end
end
