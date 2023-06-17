defmodule Expo.PO.DuplicateMessagesError do
  @moduledoc """
  An error raised when duplicate messages are detected.
  """

  @type t :: %__MODULE__{
          file: Path.t() | nil,
          duplicates: [{message :: String.t(), line :: pos_integer, original_line: pos_integer}]
        }

  defexception [:file, :duplicates]

  @impl Exception
  def message(%__MODULE__{file: file, duplicates: duplicates}) do
    prefix = if file, do: "#{Path.relative_to_cwd(file)}:", else: ""

    Enum.map_join(duplicates, "\n", fn {message, new_line, _old_line} ->
      "#{prefix}#{new_line}: #{message}"
    end)
  end
end
