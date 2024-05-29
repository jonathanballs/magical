defmodule Magical.Calendar do
  @moduledoc """
  A representation of a iCalendar VCALENDAR
  """

  defstruct prodid: nil,
            version: nil,
            time_zone: nil,
            name: nil,
            description: nil,
            events: []

  @type t :: %__MODULE__{
          prodid: String.t(),
          name: String.t(),
          description: String.t(),
          time_zone: String.t(),
          events: [Magical.Event.t()]
        }
end
