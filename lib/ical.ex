defmodule Magical do
  @moduledoc """
  Documentation for `Magical`.
  """

  alias Magical.Parser

  @doc """
    Parse an iCal string
  """
  def parse(string), do: Parser.parse(string)
end
