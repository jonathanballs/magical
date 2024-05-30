defmodule Magical.Serializer.TextSerializerTest do
  use ExUnit.Case

  alias Magical.Serializer.TextSerializer

  test "escapes escaped characters" do
    assert TextSerializer.serialize("\n") == "\\n"
  end
end
