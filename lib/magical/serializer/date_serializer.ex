defmodule Magical.Serializer.DateSerializer do
  @moduledoc false

  def serialize(%Date{} = date) do
    case Timex.format(date, "%Y%m%d", :strftime) do
      {:ok, string} -> {string, %{}}
      _ -> nil
    end
  end

  def serialize(%DateTime{} = date_time) do
    case date_time.time_zone do
      "Etc/UTC" ->
        {Timex.format!(date_time, "%Y%m%dT%H%M%SZ", :strftime), %{}}

      "UTC" ->
        {Timex.format!(date_time, "%Y%m%dT%H%M%SZ", :strftime), %{}}

      tzid ->
        {date_time |> DateTime.to_naive() |> Timex.format!("%Y%m%dT%H%M%S", :strftime),
         %{tzid: tzid}}
    end
  end

  def serialize(%NaiveDateTime{} = naive_date_time) do
    {Timex.format!(naive_date_time, "%Y%m%dT%H%M%S", :strftime), %{}}
  end
end
