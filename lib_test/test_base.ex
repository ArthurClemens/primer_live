defmodule PrimerLive.TestBase do
  @moduledoc false

  defmacro __using__(_) do
    quote do
      use ExUnit.Case
      use PrimerLive
      import Phoenix.Component
      import Phoenix.LiveViewTest

      @priv_test_result_dir "priv/test_results"
      @assertions_test_result_dir "test/assertions"
      @assertion_failures_test_result_dir "test/assertion_failures"

      def run_test(rendered, env) do
        assert rendered_to_string(rendered) |> format_html() == read_test_assertion(env.file, env.function)

      rescue
        e in ExUnit.AssertionError ->
          write_test_assertion_failure(e.left, env.file, env.function)
          reraise e, __STACKTRACE__
      end

      @doc ~S"""
      Tweaks Phoenix.LiveView.HTMLFormatter.format/2 to remove spaces surrounding HTML tags.
      """
      def format_html(html) do
        html
        |> Phoenix.LiveView.HTMLFormatter.format([])
        |> String.replace(~r/\s*\n\s*/, " ")
        |> String.replace(~r/\s*\<\s*/, "<")
        |> String.replace(~r/\s*\>\s*/, ">")
        |> String.replace(~r/<(path|circle) .*?<\/(path|circle)>/, "STRIPPED_SVG_PATHS")
        |> String.replace(~r/STRIPPED_SVG_PATHSSTRIPPED_SVG_PATHS/, "STRIPPED_SVG_PATHS")
        |> String.trim()
      end

      def to_file(result, filename, line) do
        if System.get_env("WRITE_TO_FILE") do
          dir =
            [
              @priv_test_result_dir,
              filename |> String.trim_trailing(".exs") |> String.split("/") |> List.last()
            ]
            |> Enum.join("/")

          File.mkdir_p(dir)
          File.write("#{dir}/line-#{line}.html", result)
        end
      end

      def read_test_assertion(filename, env_function) do
        path = get_test_assertion_path(@assertions_test_result_dir, filename, env_function)
        File.read!(path) |> String.trim()
      rescue
        _ ->
          "__ENOENT__"
      end
      
      def write_test_assertion_failure(result, filename, env_function) do
        path = get_test_assertion_path(@assertion_failures_test_result_dir, filename, env_function, mkdir: true)
        html = format_html(result)
        File.write!(path, html)
      end

      defp get_test_assertion_path(root_dir, filename, env_function, opts \\ []) do
        is_mkdir = Keyword.get(opts, :mkdir, false)
        dir =
          [
            root_dir,
            filename |> String.trim_trailing(".exs") |> String.split("/") |> List.last()
          ]
          |> Enum.join("/")
          
          is_mkdir && File.mkdir_p(dir)

          filename = get_filename_from_function(env_function)
          "#{dir}/#{filename}.html"
      end

      defp get_filename_from_function(env_function) do
        {test_name, _} = env_function
        test_name |> to_string() |> String.trim_leading("test ") |> String.replace(~r/[[:punct:][:space:]]/, "-")
        |> String.replace(~r/\-{2,}/, "-")
        |> String.trim()
        |> String.trim("-")
      end
    end
  end
end
