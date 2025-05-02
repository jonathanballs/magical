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

  test "last-modified and created" do
    {:ok, calendar} =
      """
      BEGIN:VCALENDAR
      VERSION:2.0
      BEGIN:VEVENT
      LAST-MODIFIED:20160615T193723Z
      CREATED:20100615T193723Z
      END:VEVENT
      END:VCALENDAR
      """
      |> Parser.parse()

    assert %Magical.Calendar{
             events: [
               %Magical.Event{
                 last_modified: ~U[2016-06-15 19:37:23Z],
                 created: ~U[2010-06-15 19:37:23Z]
               }
             ]
           } =
             calendar
  end

  describe "time zone resolution" do
    test "gracefully handles nil start or end times" do
      expected_dtstart = DateTime.shift_zone!(~U[2025-04-16 12:00:00Z], "Europe/Paris")

      {:ok,
       %Magical.Calendar{
         events: [
           %Magical.Event{
             dtstart: ^expected_dtstart,
             dtend: nil
           }
         ]
       }} =
        """
        BEGIN:VCALENDAR
        X-WR-TIMEZONE:Europe/Paris
        BEGIN:VEVENT
        DTSTART:20250416T140000
        END:VEVENT
        END:VCALENDAR
        """
        |> Parser.parse()
    end
  end
end
