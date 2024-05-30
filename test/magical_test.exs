defmodule MagicalTest do
  use ExUnit.Case
  alias Magical.Fixtures

  describe "from_ics" do
    test "Parses a dinner reservation" do
      {:ok, calendar} =
        "example.ics"
        |> Fixtures.load()
        |> Magical.from_ics()

      assert %Magical.Calendar{
               prodid: "//DesignMyNight//Booking//EN",
               version: "2.0",
               time_zone: "Europe/London",
               name: nil,
               events: [
                 %Magical.Event{
                   uid: "6529327f4eabe",
                   dtstamp: ~U[2023-10-13 12:05:19Z],
                   summary: "Booking at The King's Arms",
                   description:
                     "To cancel your booking, go to https://bookings.designmynight.com/cancel-booking?booking_id=65293276aee1f0780d4802a3&access_key=d71d4fab6d875e3fd8f6c88c62f28070.",
                   location: "251 Tooley Street, London, SE1 2JX",
                   class: "PUBLIC",
                   geo: "51.501568;-0.075906",
                   transp: "OPAQUE"
                 }
               ]
             } = calendar
    end

    test "Parses bank holidays ICS from UK government" do
      {:ok, calendar} =
        "bank-holidays.ics"
        |> Fixtures.load()
        |> Magical.from_ics()

      assert %Magical.Calendar{
               events: [
                 %Magical.Event{
                   dtstamp: ~U[2024-05-03 22:13:17Z],
                   summary: "Good Friday",
                   uid: "ca6af7456b0088abad9a69f9f620f5ac-2018-03-30-GoodFriday@gov.uk",
                   dtend: ~D[2018-03-31],
                   dtstart: ~D[2018-03-30]
                 },
                 %Magical.Event{
                   uid: "ca6af7456b0088abad9a69f9f620f5ac-2018-01-01-NewYearsDay@gov.uk",
                   dtstamp: ~U[2024-05-03 22:13:17Z],
                   summary: "New Year’s Day",
                   dtstart: ~D[2018-01-01],
                   dtend: ~D[2018-01-02]
                 }
               ],
               prodid: "-//uk.gov/GOVUK calendars//EN",
               time_zone: "Etc/UTC",
               name: nil,
               version: "2.0"
             } = calendar
    end

    test "event TZID is respected" do
      {:ok, calendar} =
        """
        BEGIN:VCALENDAR
        VERSION:2.0
        BEGIN:VEVENT
        DTSTART;TZID=America/New_York:19980119T020000
        DTEND;TZID=Europe/Paris:19980119T020000
        END:VEVENT
        END:VCALENDAR
        """
        |> Magical.from_ics()

      {:ok, dtstart} = DateTime.from_naive(~N[1998-01-19 02:00:00], "America/New_York")
      {:ok, dtend} = DateTime.from_naive(~N[1998-01-19 02:00:00], "Europe/Paris")

      assert %Magical.Calendar{
               prodid: nil,
               version: "2.0",
               time_zone: "Etc/UTC",
               name: nil,
               events: [
                 %Magical.Event{
                   uid: nil,
                   dtstamp: nil,
                   summary: nil,
                   description: nil,
                   location: nil,
                   dtstart: ^dtstart,
                   dtend: ^dtend
                 }
               ]
             } = calendar
    end

    test "Parses invalid icalendars" do
      assert {:error, :invalid} = Magical.from_ics("invalid string")
      assert {:error, :invalid} = Magical.from_ics("invalid:string")
    end
  end

  describe "from_ics!" do
    test "raises on error" do
      assert_raise ArgumentError, fn ->
        Magical.from_ics!("invalid:string")
      end
    end

    test "returns calendar directly if successful" do
      assert %Magical.Calendar{} =
               "example.ics"
               |> Fixtures.load()
               |> Magical.from_ics!()
    end
  end

  describe "to_ics" do
    test "creates an ics from an empty calendar with defaults" do
      assert """
             BEGIN:VCALENDAR
             VERSION:2.0
             METHOD:PUBLISH
             PRODID://Magical//EN
             CALSCALE:GREGORIAN
             END:VCALENDAR
             """ = Magical.to_ics(%Magical.Calendar{})
    end

    test "creates an ics calendar with empty event" do
      assert """
             BEGIN:VCALENDAR
             VERSION:2.0
             METHOD:PUBLISH
             PRODID://Magical//EN
             CALSCALE:GREGORIAN
             BEGIN:VEVENT
             END:VEVENT
             END:VCALENDAR
             """ =
               Magical.to_ics(%Magical.Calendar{
                 events: [%Magical.Event{}]
               })
    end
  end
end
