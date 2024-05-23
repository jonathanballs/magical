# Magical

[![Hex.pm Version](https://img.shields.io/hexpm/v/magical?style=flat-square&labelColor=%2334495e&color=%238e44ad)](https://hex.pm/packages/magical/)
[![Docs](https://img.shields.io/badge/hexdocs-34495e?style=flat-square)](https://hexdocs.pm/magical/)
[![Coverage Status](https://coveralls.io/repos/github/jonathanballs/magical/badge.svg?branch=main)](https://coveralls.io/github/jonathanballs/magical?branch=main)

Magical is a [RFC 5545](https://www.ietf.org/rfc/rfc5545.txt) compatible parser
for iCalendar files.

A better iCalendar parser for Elixir. Magical has full time zone support
(including for `X-WR-TIMEZONE`) and supports many common (but non-standard)
options such as `X-WR-CALNAME` and `X-WR-DESC`.

## Installation

```elixir
def deps do
  [
    {:magical, "~> 0.1.2"}
  ]
end
```
