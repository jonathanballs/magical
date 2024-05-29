defmodule Magical do
  @moduledoc """
  Documentation for `Magical`.
  """

  alias Magical.Parser
  alias Magical.Serializer

  @doc """
  Parse an iCalendar string and return the result as a Magical.Calendar struct
  """
  @callback from_ics(String.t()) :: {:ok, Magical.Calendar.t()} | {:error, :invalid}
  @spec from_ics(String.t()) :: {:ok, Magical.Calendar.t()} | {:error, :invalid}
  def from_ics(string), do: Parser.parse(string)

  @doc """
  Parse an iCalendar string and return the result as a Magical.Calendar struct.
  This function will throw an ArgumentError if the input is invalid
  """
  @callback from_ics!(String.t()) :: Magical.Calendar.t()
  @spec from_ics!(String.t()) :: Magical.Calendar.t()
  def from_ics!(string) do
    case Parser.parse(string) do
      {:ok, calendar} -> calendar
      _ -> raise %ArgumentError{message: "invalid iCalendar file"}
    end
  end

  @spec to_ics(Magical.Calendar.t()) :: String.t()
  def to_ics(%Magical.Calendar{} = calendar) do
    Serializer.serialize(calendar)
  end
end
