defmodule PrimerLive.Helpers.Octicons do
  @moduledoc false

  require EEx

  @priv_path "priv/octicon_builder"
  @module_path "lib/octicons.ex"

  EEx.function_from_file(
    :defp,
    :module_wrapper,
    "#{@priv_path}/PrimerLive.Octicons.template.eex",
    [:icons]
  )

  def build() do
    with {:ok, filenames} <- File.ls("#{@priv_path}/icons") do
      with true <- Enum.count(filenames) > 0 do
      else
        _ ->
          IO.inspect("Could not proceed: directory '#{@priv_path}/icons' is empty.")
      end

      icons =
        filenames
        |> Enum.map(
          &%{
            svg:
              File.read!("#{@priv_path}/icons/#{&1}")
              |> String.replace(~r/\<svg/, "<svg class={@class} {@rest}"),
            name: &1 |> String.replace(".svg", ""),
            function_name: &1 |> String.replace(".svg", "") |> String.replace("-", "_")
          }
        )

      result = module_wrapper(icons)

      with :ok <- File.write(@module_path, result) do
        IO.puts("PrimerLive.Octicons module written")
      else
        error ->
          IO.puts("Error writing PrimerLive.Octicons module")
          error
      end
    else
      _error ->
        IO.inspect("Could not read directory '#{@priv_path}/icons'. Does this directory exist?")
    end
  end
end
