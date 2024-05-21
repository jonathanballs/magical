defmodule Magical do
  @moduledoc """
  Documentation for `Magical`.
  """

  alias Magical.Parser

  @doc """
    Parse an iCal string
  """
  @callback parse(String.t()) :: {:ok, Magical.Calendar.t()} | {:error, :invalid}
  @spec parse(String.t()) :: {:ok, Magical.Calendar.t()} | {:error, :invalid}
  def parse(string), do: Parser.parse(string)
end
