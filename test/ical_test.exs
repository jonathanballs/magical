defmodule ICalTest do
  use ExUnit.Case
  alias ICal.Fixtures

  test "Parses a dinner reservation" do
    {:ok, calendar} =
      "example.ics"
      |> Fixtures.load()
      |> ICal.parse()

    assert %ICal.Calendar{
             prodid: "//DesignMyNight//Booking//EN",
             version: "2.0",
             time_zone: "Europe/London",
             title: nil,
             events: [
               %ICal.Event{
                 uid: "6529327f4eabe",
                 dtstamp: ~U[2023-10-13 12:05:19Z],
                 summary: "Booking at The King's Arms",
                 description:
                   "To cancel your booking\\, go to https://bookings.designmynight.com/cancel-booking?booking_id=65293276aee1f0780d4802a3&access_key=d71d4fab6d875e3fd8f6c88c62f28070.",
                 location: "251 Tooley Street\\, London\\, SE1 2JX",
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
      |> ICal.parse()

    assert %ICal.Calendar{
             events: [
               %ICal.Event{
                 dtstamp: ~U[2024-05-03 22:13:17Z],
                 summary: "Good Friday",
                 uid: "ca6af7456b0088abad9a69f9f620f5ac-2018-03-30-GoodFriday@gov.uk",
                 dtend: ~D[2018-03-31],
                 dtstart: ~D[2018-03-30]
               },
               %ICal.Event{
                 uid: "ca6af7456b0088abad9a69f9f620f5ac-2018-01-01-NewYearsDay@gov.uk",
                 dtstamp: ~U[2024-05-03 22:13:17Z],
                 summary: "New Year’s Day",
                 dtstart: ~D[2018-01-01],
                 dtend: ~D[2018-01-02]
               }
             ],
             prodid: "-//uk.gov/GOVUK calendars//EN",
             time_zone: "Etc/UTC",
             title: nil,
             version: "2.0"
           } = calendar
  end
end
