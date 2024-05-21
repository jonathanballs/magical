defmodule Magical.Fixtures do
  def load(path) do
    File.cwd!()
    |> Path.join("test/support/fixtures")
    |> Path.join(path)
    |> File.read!()
  end
end
