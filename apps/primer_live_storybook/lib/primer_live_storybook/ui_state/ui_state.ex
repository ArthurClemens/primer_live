defmodule PrimerLiveStorybook.UIState do
  use Ecto.Schema

  schema "ui-state" do
    field(:mobile_side_drawer_open, :boolean)
    field(:theme_menu_open, :boolean)
  end
end
