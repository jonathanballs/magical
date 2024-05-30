defmodule Magical.Serializer.DateSerializerTest do
  alias Magical.Serializer.DateSerializer
  use ExUnit.Case

  test "serializes dates" do
    date = Date.new!(2024, 01, 01)
    assert DateSerializer.serialize(date) == {"20240101", %{value: "DATE"}}
  end

  test "serializes date times" do
    assert DateSerializer.serialize(~U[1997-07-01 00:00:00Z]) == {"19970701T000000Z", %{}}

    # Treat UTC like Etc/UTC
    {:ok, date_time} = DateTime.from_naive(~N[1998-01-19 07:00:00], "UTC")
    assert DateSerializer.serialize(date_time) == {"19980119T070000Z", %{}}

    # Time zoned date times converted to naive and include correct tzid
    {:ok, date_time} = DateTime.from_naive(~N[1998-01-19 07:00:00], "Asia/Bangkok")
    assert DateSerializer.serialize(date_time) == {"19980119T070000", %{tzid: "Asia/Bangkok"}}
  end

  test "serializes naive datetimes" do
    date_time = ~N[1998-01-19 07:00:00]
    assert DateSerializer.serialize(date_time) == {"19980119T070000", %{}}
  end
end
