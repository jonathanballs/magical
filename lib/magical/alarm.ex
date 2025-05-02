defmodule Magical.Alarm do
  @moduledoc """
  A representation of a iCalendar VALARM
  """

  defstruct uid: nil,
  acknowledged: nil,
  action: nil,
  description: nil,
  trigger: nil,
  x_wr_alarm_uid: nil,
  x_apple_default_alarm: nil


  @type t :: %__MODULE__{
    uid: String.t(),
    acknowledged: DateTime.t(),
    action: String.t(),
    description: String.t(),
    trigger: Duration.t() | DateTime.t(),
    x_wr_alarm_uid: String.t(),
    x_apple_default_alarm: boolean() | nil
  }
end