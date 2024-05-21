defmodule Magical.Fixtures do
  @moduledoc false

  @doc """
  Loads a file from the fixtures directory and returns it as a string. Path
  should be the file path relative to the fixtures directory
  """
  def load(path) do
    File.cwd!()
    |> Path.join("test/support/fixtures")
    |> Path.join(path)
    |> File.read!()
  end
end
