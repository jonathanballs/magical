defmodule Magical do
  @moduledoc """
  Documentation for `Magical`.
  """

  alias Magical.Parser

  @doc """
    Parse an iCal string
  """
  @spec parse(String.t()) :: {:ok, Magical.Calendar.t()} | {:error, :invalid}
  def parse(string), do: Parser.parse(string)
end
