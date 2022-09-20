defmodule PrimerLive.Options.ValidationData do
  use Options

  @moduledoc false

  typed_embedded_schema do
    field(:is_error, :boolean, enforce: true)
    field(:has_message, :boolean, enforce: true)
    field(:message, :string, enforce: true)
    field(:validation_message_id, :string, enforce: true)
  end

  @impl Options
  def changeset(struct, attrs \\ %{}) do
    struct
    |> cast(attrs, [
      :is_error,
      :has_message,
      :message,
      :validation_message_id
    ])
    |> validate_required([:is_error, :has_message, :message, :validation_message_id])
  end
end
