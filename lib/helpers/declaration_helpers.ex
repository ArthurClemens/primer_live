defmodule PrimerLive.Helpers.DeclarationHelpers do
  defmacro class() do
    quote do
      attr(:class, :string, default: nil, doc: "Additional classname.")
    end
  end

  defmacro input_id() do
    quote do
      attr(:input_id, :string,
        default: nil,
        doc:
          "When using form/field. Custom input ID to be used in case the generated IDs cause \"Multiple IDs detected\" errors."
      )
    end
  end
end
