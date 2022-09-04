defmodule Options do
  @moduledoc false

  @callback changeset(struct(), map()) :: Ecto.Changeset.t()

  defmacro __using__(opts) do
    quote do
      @behaviour Options

      use TypedEctoSchema

      import Ecto.Changeset

      @primary_key false

      unquote(add_builder(opts))
    end
  end

  defmacro __before_compile__(_) do
    quote do
      defp cast_embed_with_defaults(changeset, attrs, key, defaults) do
        values = attrs[key] || %{}
        changeset |> put_embed(key, Map.merge(defaults, values))
      end

      @doc false
      def parse(attrs) do
        struct(__MODULE__)
        |> changeset(attrs)
        |> apply_action(:build)
      end
    end
  end

  defp add_builder(opts) do
    if Keyword.get(opts, :parser, true) do
      quote do
        @before_compile Options
      end
    end
  end
end
