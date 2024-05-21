defmodule ICal.Parser.DateParser do
  @moduledoc """
  Responsible for parsing datestrings in predefined formats with `parse/1` and
  `parse/2`.
  """

  @doc """
  Responsible for parsing datestrings in predefined formats into %DateTime{}
  structs. Valid formats are defined by the "Internet Calendaring and Scheduling
  Core Object Specification" (RFC 2445).

    - **Full text:**      http://www.ietf.org/rfc/rfc2445.txt
    - **DateTime spec:**  http://www.kanzaki.com/docs/ical/dateTime.html
    - **Date spec:**      http://www.kanzaki.com/docs/ical/date.html
  """

  @spec parse(String.t()) :: %DateTime{}
  def parse(data)

  # Date Format: "19690620T201804Z"
  def parse(<<_date::binary-size(8), "T", _time::binary-size(6), "Z">> = date_time) do
    with {:ok, naive_date_time} <- Timex.parse(date_time, "%Y%m%dT%H%M%SZ", :strftime),
         {:ok, date_time} <- DateTime.from_naive(naive_date_time, "Etc/UTC") do
      DateTime.truncate(date_time, :second)
    end
  end

  # Date Format: "19690620T201804"
  def parse(<<_date::binary-size(8), "T", _time::binary-size(6)>> = date_time) do
    case Timex.parse(date_time, "%Y%m%dT%H%M%S", :strftime) do
      {:ok, naive_date_time} -> NaiveDateTime.truncate(naive_date_time, :second)
      _error -> nil
    end
  end

  # Date Format: "19690620"
  def parse(<<_date::binary-size(8)>> = date_time) do
    with {:ok, naive_date_time} <- Timex.parse(date_time, "%Y%m%d", :strftime) do
      NaiveDateTime.to_date(naive_date_time)
    end
  end

  def parse(_) do
    nil
  end
end

