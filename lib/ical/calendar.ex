defmodule ICal.Calendar do
  defstruct prodid: nil,
            version: nil,
            time_zone: "Etc/UTC",
            events: [],
            children: []
end
