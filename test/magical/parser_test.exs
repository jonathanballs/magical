defmodule Magical.ParserTest do
  use ExUnit.Case
  alias Magical.Parser

  describe "Calendar.name" do
    test "no name" do
      {:ok, calendar} =
        """
        BEGIN:VCALENDAR
        VERSION:2.0
        END:VCALENDAR
        """
        |> Parser.parse()

      assert %Magical.Calendar{name: nil} = calendar
    end

    test "x-wr-calname:" do
      {:ok, calendar} =
        """
        BEGIN:VCALENDAR
        VERSION:2.0
        X-WR-CALNAME:Test calendar name
        END:VCALENDAR
        """
        |> Parser.parse()

      assert %Magical.Calendar{name: "Test calendar name"} = calendar
    end

    test "x-name:" do
      {:ok, calendar} =
        """
        BEGIN:VCALENDAR
        VERSION:2.0
        X-NAME:Test calendar name
        END:VCALENDAR
        """
        |> Parser.parse()

      assert %Magical.Calendar{name: "Test calendar name"} = calendar
    end

    test "name:" do
      {:ok, calendar} =
        """
        BEGIN:VCALENDAR
        VERSION:2.0
        NAME:Test calendar name
        END:VCALENDAR
        """
        |> Parser.parse()

      assert %Magical.Calendar{name: "Test calendar name"} = calendar
    end
  end

  describe "Calendar.description" do
    test "descripion:" do
      {:ok, calendar} =
        """
        BEGIN:VCALENDAR
        VERSION:2.0
        DESCRIPTION:test description
        END:VCALENDAR
        """
        |> Parser.parse()

      assert %Magical.Calendar{description: "test description"} = calendar
    end

    test "x-wr-caldesc:" do
      {:ok, calendar} =
        """
        BEGIN:VCALENDAR
        VERSION:2.0
        X-WR-CALDESC:test description
        END:VCALENDAR
        """
        |> Parser.parse()

      assert %Magical.Calendar{description: "test description"} = calendar
    end
  end

  test "last-modified" do
    {:ok, calendar} =
      """
      BEGIN:VCALENDAR
      VERSION:2.0
      BEGIN:VEVENT
      LAST-MODIFIED:20160615T193723Z
      END:VEVENT
      END:VCALENDAR
      """
      |> Parser.parse()

    assert %Magical.Calendar{events: [%Magical.Event{last_modified: ~U[2016-06-15 19:37:23Z]}]} =
             calendar
  end
end
