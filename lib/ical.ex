defmodule Magical do
  @moduledoc """
  Documentation for `Ical`.
  """

  alias Magical.Parser

  defdelegate parse(string), to: Parser
end
