defmodule Magical.Parser.DateParser do
  @moduledoc """
  Responsible for parsing datestrings in predefined formats with `parse/1`.
  """

  @doc """
  Responsible for parsing datestrings in predefined formats into %DateTime{}
  structs. Valid formats are defined by the "Internet Calendaring and Scheduling
  Core Object Specification" (RFC 2445).

    - **Full text:**      http://www.ietf.org/rfc/rfc2445.txt
    - **DateTime spec:**  http://www.kanzaki.com/docs/ical/dateTime.html
    - **Date spec:**      http://www.kanzaki.com/docs/ical/date.html
  """
  @spec parse(String.t(), Map.t()) :: DateTime.t() | NaiveDateTime.t() | Date.t() | nil
  def parse(date_string, args \\ %{})

  def parse(date_string, %{"tzid" => time_zone} = args) do
    case parse(date_string, Map.delete(args, "tzid")) do
      %NaiveDateTime{} = ndt ->
        safe_add_timezone(ndt, time_zone)

      dt ->
        dt
    end
  end

  def parse(date_string, %{"value" => "DATE"} = args) do
    case parse(date_string, Map.delete(args, "value")) do
      %NaiveDateTime{} = date_time -> NaiveDateTime.to_date(date_time)
      %DateTime{} = date_time -> DateTime.to_date(date_time)
      dt -> dt
    end
  end

  def parse(date, %{"value" => "DATE-TIME"} = args) do
    case parse(date, Map.delete(args, "value")) do
      %Date{} = date -> NaiveDateTime.new!(date, ~T[00:00:00])
      dt -> dt
    end
  end

  def parse(date, _args) do
    parse_string(date)
  end

  # Date Format: "19690620T201804Z"
  defp parse_string(<<_date::binary-size(8), "T", _time::binary-size(6), "Z">> = date_time) do
    with {:ok, naive_date_time} <- Timex.parse(date_time, "%Y%m%dT%H%M%SZ", :strftime),
         {:ok, date_time} <- DateTime.from_naive(naive_date_time, "Etc/UTC") do
      DateTime.truncate(date_time, :second)
    else
      _ -> nil
    end
  end

  # Date Format: "19690620T201804"
  defp parse_string(<<_date::binary-size(8), "T", _time::binary-size(6)>> = date_time) do
    case Timex.parse(date_time, "%Y%m%dT%H%M%S", :strftime) do
      {:ok, naive_date_time} -> NaiveDateTime.truncate(naive_date_time, :second)
      _error -> nil
    end
  end

  # Date Format: "19690620"
  defp parse_string(<<_date::binary-size(8)>> = date_time) do
    with {:ok, naive_date_time} <- Timex.parse(date_time, "%Y%m%d", :strftime) do
      NaiveDateTime.to_date(naive_date_time)
    else
      _ -> nil
    end
  end

  defp parse_string(_), do: nil

  defp safe_add_timezone(ndt, time_zone) do
    case DateTime.from_naive(ndt, time_zone) do
      {:ok, dt} -> dt
      _ -> nil
    end
  end
end
