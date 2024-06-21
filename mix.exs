defmodule Magical.MixProject do
  use Mix.Project

  @source_url "https://github.com/jonathanballs/magical"
  def project do
    [
      name: "Magical",
      description: "An RFC 5545 compatible iCalendar parser",
      app: :magical,
      test_coverage: [tool: ExCoveralls],
      package: package(),
      version: "1.0.1",
      elixir: "~> 1.16",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      source_url: @source_url,
      deps: deps(),
      docs: docs()
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.33", only: :dev, runtime: false},
      {:excoveralls, "~> 0.18.1", only: :test},
      {:mix_test_watch, "~> 1.0", only: [:dev, :test], runtime: false},
      {:nimble_parsec, "~> 1.4"},
      {:timex, "~> 3.7"}
    ]
  end

  defp package do
    [
      links: %{"GitHub" => "https://github.com/jonathanballs/magical"},
      licenses: ["Apache-2.0"]
    ]
  end

  defp docs() do
    [
      main: "readme",
      name: "Magical",
      canonical: "http://hexdocs.pm/magical",
      source_url: @source_url,
      extras: ["README.md", "LICENSE"]
    ]
  end
end
