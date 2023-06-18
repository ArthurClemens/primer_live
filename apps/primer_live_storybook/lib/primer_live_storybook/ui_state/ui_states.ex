defmodule PrimerLiveStorybook.UIStates do
  use Ecto.Schema
  import Ecto.Changeset
  alias PrimerLiveStorybook.{UIState}

  @allowed_fields [:mobile_side_drawer_open, :theme_menu_open]
  @required_fields @allowed_fields

  def change(%UIState{} = ui_state, attrs \\ %{}) do
    changeset(ui_state, attrs)
  end

  defp simulate_repo_state(changeset, action) do
    case changeset.valid? do
      true -> apply_action(changeset, :update)
      false -> {:error, changeset |> Map.put(:action, action)}
    end
  end

  defp changeset(ui_state, attrs \\ %{}) do
    ui_state
    |> cast(attrs, @allowed_fields)
    |> Ecto.Changeset.validate_required(@required_fields)
  end
end
