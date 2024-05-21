defmodule Magical.MixProject do
  use Mix.Project

  def project do
    [
      name: "Magical",
      description: "An iCal parser with better time zone support",
      app: :magical,
      package: package(),
      version: "0.1.2",
      elixir: "~> 1.16",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      source_url: "https://github.com/jonathanballs/magical",
      deps: deps()
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
      {:mix_test_watch, "~> 1.0", only: [:dev, :test], runtime: false},
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.33", only: :dev, runtime: false},
      {:timex, "~> 3.7"}
    ]
  end

  defp package do
    [
      links: %{"GitHub" => "https://github.com/jonathanballs/magical"},
      licenses: ["Apache-2.0"]
    ]
  end
end
