defmodule ICal do
  @moduledoc """
  Documentation for `Ical`.
  """

  alias ICal.Parser

  defdelegate parse(string), to: Parser
end
