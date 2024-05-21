# Magical

A better iCalendar parser for Elixir. Magical has full time zone support
(including for `X-WR-TIMEZONE`) and supports many common (but non-standard)
options such as `X-WR-CALNAME` and `X-WR-DESC`.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `ical` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:magical, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/magical>.
