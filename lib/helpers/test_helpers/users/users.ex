defmodule PrimerLive.TestHelpers.Repo.Users do
  @moduledoc false

  import Ecto.Changeset, except: [change: 1]
  alias PrimerLive.TestHelpers.Repo.User

  def change(%User{} = user, attrs \\ %{}) do
    user
    |> changeset(attrs)
  end

  def init do
    change(%User{})
  end

  @allowed_fields [
    :first_name,
    :available_for_hire,
    :work_experience
  ]

  @required_fields [
    :first_name,
    :available_for_hire
  ]

  defp changeset(user, attrs) do
    user
    |> cast(attrs, @allowed_fields)
    |> validate_required(@required_fields)
  end
end
