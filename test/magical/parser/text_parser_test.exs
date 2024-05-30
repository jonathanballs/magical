defmodule Magical.Parser.TextParserTest do
  use ExUnit.Case

  alias Magical.Parser.TextParser

  test "handles escaped chars" do
    assert TextParser.parse("hello\\nworld") == "hello\nworld"
    assert TextParser.parse("hello\\Nworld") == "hello\nworld"
    assert TextParser.parse("hello\\\\world") == "hello\\world"
    assert TextParser.parse("hello\\;world") == "hello;world"
    assert TextParser.parse("hello\\,world") == "hello,world"
  end

  test "returns original string if invalid escapes" do
    assert TextParser.parse("hello\\pworld") == "hello\\pworld"
    assert TextParser.parse("\\") == "\\"
  end

  test "handles unescaped characters gracefully" do
    assert TextParser.parse("visit: https://unescaped.com") == "visit: https://unescaped.com"

    assert TextParser.parse("\\\\n") == "\\n"
    assert TextParser.parse("\\\\\\n") == "\\\n"

    assert TextParser.parse("https://unescaped.com and\\, escaped") ==
             "https://unescaped.com and, escaped"
  end

  test "handles utf8 characters" do
    assert TextParser.parse("曆") == "曆"
  end

  test "parsing is opposite of serialization" do
    test_string = ~S("\;,:)

    assert test_string
           |> Magical.Serializer.TextSerializer.serialize()
           |> TextParser.parse() ==
             test_string
  end
end
