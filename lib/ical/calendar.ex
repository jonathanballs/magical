defmodule ICal.Calendar do
  defstruct prodid: nil,
            version: nil,
            time_zone: "Etc/UTC",
            title: nil,
            events: [],
            children: []
end
