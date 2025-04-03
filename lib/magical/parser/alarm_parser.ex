defmodule Magical.Parser.AlarmParser do
  @moduledoc false

  alias Magical.Alarm
  alias Magical.Parser.DateParser
  alias Magical.Parser.TextParser
  alias Magical.Parser.DurationParser

  def parse(lines) do
    Enum.reduce(lines, %Alarm{}, &parse_alarm/2)
  end

  defp parse_alarm({"uid", uid, _args}, alarm) do
    Map.put(alarm, :uid, TextParser.parse(uid))
  end

  defp parse_alarm({"x-wr-alarmuid", uid, _args}, alarm) do
    Map.put(alarm, :x_wr_alarm_uid, TextParser.parse(uid))
  end

  defp parse_alarm({"acknowledged", datetime, args}, alarm) do
    Map.put(alarm, :acknowledged, DateParser.parse(datetime, args))
  end

  defp parse_alarm({"action", action, _args}, alarm) do
    Map.put(alarm, :action, TextParser.parse(action))
  end

  defp parse_alarm({"description", description, _args}, alarm) do
    Map.put(alarm, :action, TextParser.parse(description))
  end

  defp parse_alarm({"trigger", trigger, args}, alarm) do
    Map.put(alarm, :trigger, DurationParser.parse(trigger, args))
  end

  defp parse_alarm({"x-apple-default-alarm", "TRUE", _args}, alarm) do
    Map.put(alarm, :x_apple_default_alarm, true)
  end

  defp parse_alarm({"x-apple-default-alarm", "FALSE", _args}, alarm) do
    Map.put(alarm, :x_apple_default_alarm, false)
  end

  defp parse_alarm({"x-apple-default-alarm", _, _args}, alarm) do
    Map.put(alarm, :x_apple_default_alarm, nil)
  end

  defp parse_alarm({"end", "VALARM", _args}, alarm) do
    alarm
  end

end