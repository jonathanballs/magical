defmodule Magical do
  @moduledoc """
  Documentation for `Magical`.
  """

  alias Magical.Parser

  @doc """
    Parse an iCal string
  """
  @callback from_ics(String.t()) :: {:ok, Magical.Calendar.t()} | {:error, :invalid}
  @spec from_ics(String.t()) :: {:ok, Magical.Calendar.t()} | {:error, :invalid}
  def from_ics(string), do: Parser.parse(string)

  @doc """
    Parse an iCal string
  """
  @callback from_ics!(String.t()) :: {:ok, Magical.Calendar.t()} | {:error, :invalid}
  @spec from_ics!(String.t()) :: {:ok, Magical.Calendar.t()} | {:error, :invalid}
  def from_ics!(string) do
    case Parser.parse(string) do
      {:ok, calendar} -> calendar
      _ -> raise %ArgumentError{message: "invalid iCalendar file"}
    end
  end
end
