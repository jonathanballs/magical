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
  end

  test "handles unescaped characters gracefully" do
    assert TextParser.parse("visit: https://unescaped.com") == "visit: https://unescaped.com"

    assert TextParser.parse("https://unescaped.com and\\, escaped") ==
             "https://unescaped.com and, escaped"
  end
end
