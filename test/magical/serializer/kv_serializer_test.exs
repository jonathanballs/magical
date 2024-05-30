defmodule Magical.Serializer.KvSerializerTest do
  use ExUnit.Case
  alias Magical.Serializer.KvSerializer

  test "Makes name and param names uppercase" do
    assert KvSerializer.serialize(:name, "My Test Name", %{value: "DATE"}) ==
             "NAME;VALUE=DATE:My Test Name\n"
  end

  test "wraps very long lines" do
    assert KvSerializer.serialize(:description, String.duplicate("a", 200)) ==
             """
             DESCRIPTION:aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
              aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
              aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
             """
  end
end
