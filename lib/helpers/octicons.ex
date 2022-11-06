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

  def build(dirname) do
    icons_path = "#{@priv_path}/#{dirname}/icons"

    with {:ok, filenames} <- File.ls(icons_path) do
      with true <- Enum.count(filenames) > 0 do
      else
        _ ->
          IO.inspect("Could not proceed: directory '#{icons_path}' is empty.")
      end

      icons =
        filenames
        |> Enum.map(
          &%{
            svg:
              File.read!("#{icons_path}/#{&1}")
              |> String.replace(~r/\<svg/, "<svg class={@class} {@rest}"),
            name: &1 |> String.replace(".svg", "")
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
        IO.inspect("Could not read directory '#{icons_path}'. Does this directory exist?")
    end
  end
end
