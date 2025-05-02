defmodule Magical.Parser.DurationParser do
  @moduledoc """
  Responsible for parsing durations or delegating to
  datetime parsing.
  """

  alias Magical.Parser.DateParser

  def parse("P" <> _rest = duration_string, _args) do
    Duration.from_iso8601!(duration_string)
  end

  def parse("-P" <> _rest = duration_string, _args) do
    Duration.from_iso8601!(duration_string)
  end

  def parse(datetime_string, args) do
    DateParser.parse(datetime_string, args)
  end

end