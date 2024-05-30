# Magical

[![Hex.pm Version](https://img.shields.io/hexpm/v/magical?style=flat-square&labelColor=%2334495e&color=%238e44ad)](https://hex.pm/packages/magical/)
[![Docs](https://img.shields.io/badge/hexdocs-34495e?style=flat-square)](https://hexdocs.pm/magical/)
[![Coverage Status](https://coveralls.io/repos/github/jonathanballs/magical/badge.svg?branch=main)](https://coveralls.io/github/jonathanballs/magical?branch=main)

Magical is a [RFC 5545](https://www.ietf.org/rfc/rfc5545.txt) compatible parser
and serializer for iCalendar files. It parses the file intelligently by
converting values into native Elixir types and resolving time zones
automatically.

Magical is designed to comply with [Postel's
law](https://en.wikipedia.org/wiki/Robustness_principle) - which means that it
is lenient in what it accepts and strict in what it produces. It accepts and
supports the more common non-standard extensions to iCalendar such as
`X-WR-TIMEZONE`, `X-WR-CALNAME` or `X-WR-DESC`. It will also gracefully handle
poor character escaping and other idiosyncrasies found in real world ICS files.
Internally it uses [NimbleParsec](https://github.com/dashbitco/nimble_parsec)
to ensure robust parsing of escaped strings. It has been tested against a
variety of edge cases and noncompliant ics files. The iCalendar files that it
produces are tested against both the iCalendar spec as well as real calendar
software.

## Installation

Just add `magical` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:magical, "~> 0.1.3"}
  ]
end
```

## Quickstart

```elixir
"test.ics"
|> File.read!()
|> Magical.from_ics()
{:ok,
 %Magical.Calendar{
   prodid: "//Magical//Booking//EN",
   version: "2.0",
   time_zone: "Europe/London",
   name: nil,
   description: nil,
   events: [
     %Magical.Event{
       uid: "6529327f4eabe",
       dtstamp: ~U[2023-10-13 12:05:19Z],
       summary: "Booking at The King's Arms",
       description: "Your booking is confirmed for 6 people at 2 o'clock",
       location: "251 Tooley Street, London, SE1 2JX",
       dtstart: #DateTime<2023-10-13 19:00:00+01:00 BST Europe/London>,
       dtend: #DateTime<2023-10-13 21:00:00+01:00 BST Europe/London>,
       class: "PUBLIC",
       created: nil,
       geo: "51.501568;-0.075906",
       last_modified: nil,
       organizer: nil,
       priority: nil,
       seq: nil,
       status: nil,
       transp: "OPAQUE",
       url: nil,
       recurid: nil,
       rrule: nil,
       attach: nil,
       attendee: nil,
       categories: nil,
       comment: nil,
       contact: nil,
       exdate: nil,
       rstatus: nil,
       related: nil,
       resources: nil,
       rdate: nil,
       x_prop: nil,
       iana_prop: nil
     }
   ]
 }}
```
