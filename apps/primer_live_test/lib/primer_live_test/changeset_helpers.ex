defmodule PrimerLiveTest.ChangesetHelpers do
  @moduledoc """
  From https://gist.github.com/brainlid/9dcf78386e68ca03d279ae4a9c8c2373 via https://fly.io/phoenix-files/making-a-checkboxgroup-input/

  Helper functions for working with changesets.
  Includes common specialized validations for working with tags.
  """
  import Ecto.Changeset

  @doc """
  Remove the blank value from the array.
  """
  def trim_array(changeset, field, blank_value \\ "") do
    update_change(changeset, field, &Enum.reject(&1, fn item -> item == blank_value end))
  end

  @doc """
  Validate that the array of string on the changeset are all in the set of valid
  values.

  NOTE: Could use `Ecto.Changeset.validate_subset/4` instead, however, it won't
  give as helpful errors.
  """
  def validate_array(changeset, field, valid_values) when is_list(valid_values) do
    validate_change(changeset, field, fn ^field, new_values ->
      if Enum.all?(new_values, &(&1 in valid_values)) do
        []
      else
        unsupported = new_values -- valid_values
        [{field, "Only the defined values are allowed. Unsupported: #{inspect(unsupported)}"}]
      end
    end)
  end

  def validate_array(changeset, _field, _valid_values), do: changeset

  @doc """
  Clean and process the array values and validate the selected values against an
  approved list.
  """
  def clean_and_validate_array(changeset, field, valid_values, blank_value \\ "") do
    changeset
    |> trim_array(field, blank_value)
    |> validate_array(field, valid_values)
  end
end
