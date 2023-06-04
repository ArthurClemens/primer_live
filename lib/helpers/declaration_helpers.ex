defmodule PrimerLive.Helpers.DeclarationHelpers do
  defmacro class() do
    quote do
      attr(:class, :string, default: nil, doc: "Additional classname.")
    end
  end
end
