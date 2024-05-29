defmodule Magical.Serializer.EventSerializer do
  alias Magical.Event

  def serialize(%Event{} = _event) do
    """
    BEGIN:VEVENT
    END:VEVEVENT
    """
  end
end
