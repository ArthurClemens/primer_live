defmodule PrimerLive.Helpers.SchemaHelpers do
  @moduledoc false

  use Phoenix.Component

  import Ecto.Changeset

  @doc """
  Validates a changeset by verifying that at least one of the keys is present.

  ```
  changeset |> validate_one_of_present(attrs, [:toggle, :menu, :option, :divider])
  ```
  """

  def validate_one_of_present(changeset, attrs, keys) do
    attr_keys = Map.keys(attrs)

    in_list_count =
      keys
      |> Enum.reduce(0, fn key, acc ->
        case Enum.member?(attr_keys, key) do
          true -> acc + 1
          false -> acc
        end
      end)

    case in_list_count == 0 do
      true ->
        add_error(
          changeset,
          :dropdown_item,
          "must contain one attribute from these options: #{keys |> Enum.join(", ")}"
        )

      false ->
        changeset
    end
  end

  def is_phoenix_form(%Phoenix.HTML.Form{}), do: true
  def is_phoenix_form(_), do: false
end
