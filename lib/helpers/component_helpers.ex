defmodule PrimerLive.Helpers.ComponentHelpers do
  @moduledoc false

  @doc ~S"""
  Returns nil if the rendered slot has no content, otherwise returns the rendered content.
  This is useful for providing fallback content in case a slot inner_block exists, but the rendered result may be empty.

  Usage in a template:

  ```
  <%= render_slot(my_slot) |> ComponentHelpers.maybe_slot_content() || "Fallback" %>
  ```

      iex> PrimerLive.Helpers.ComponentHelpers.maybe_slot_content(%Phoenix.LiveView.Rendered{
      ...>   static: [""]
      ...> })
      nil

      iex> PrimerLive.Helpers.ComponentHelpers.maybe_slot_content(%Phoenix.LiveView.Rendered{
      ...>   static: [" \n  \n "]
      ...> })
      nil

      iex> PrimerLive.Helpers.ComponentHelpers.maybe_slot_content(%Phoenix.LiveView.Rendered{
      ...>   static: [" \n Content \n "]
      ...> })
      %Phoenix.LiveView.Rendered{static: [" \n Content \n "], dynamic: nil, fingerprint: nil, root: nil, caller: :not_available}
  """
  def maybe_slot_content(rendered) do
    case has_slot_content(rendered) do
      true -> rendered
      false -> nil
    end
  end

  defp has_slot_content(rendered), do: !empty_slot?(rendered)
  defp empty_slot?(rendered) when is_nil(rendered), do: false
  defp empty_slot?(rendered), do: empty_slot_content?(rendered.static)
  defp empty_slot_content?(static) when is_nil(static), do: true
  defp empty_slot_content?(static) when static == [""], do: true

  defp empty_slot_content?(static) do
    cond do
      static == [] -> true
      hd(static) |> String.trim() == "" -> true
      true -> false
    end
  end

  def deprecated_message(message), do: deprecated_message(message, true)

  def deprecated_message(message, condition) do
    if condition && Application.get_env(:primer_live, :env) !== :test do
      IO.puts(message)
    end
  end

  def missing_attribute(name) do
    IO.puts("Missing attribute: #{name}")
  end
end
