defmodule PrimerLive.TestBase do
  @moduledoc false

  defmacro __using__(_) do
    quote do
      use ExUnit.Case
      use PrimerLive
      use Phoenix.Component
      import Phoenix.Component
      import Phoenix.LiveViewTest

      @priv_test_result_dir "priv/test_results"
      @assertions_test_result_dir "test/assertions"
      @assertion_failures_test_result_dir "test/assertion_failures"

      def run_test(rendered, env) do
        html = rendered_to_string(rendered) |> format_html()
        html_tree_string = create_html_tree_string(html)

        {error, stacktrace} =
          try do
            assert html_tree_string == read_test_assertion(env.file, env.function)
            {nil, nil}
          rescue
            error in ExUnit.AssertionError ->
              {error, __STACKTRACE__}
          end

        if error do
          if System.get_env("WRITE_FAILURES") do
            write_test_assertion_failure(html, env.file, env.function)
          end

          reraise error, stacktrace
        end
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
        |> String.trim()
      end

      defp create_html_tree_string(html) do
        Floki.parse_fragment!(html, attributes_as_maps: true)
        |> inspect()
      end

      defp read_test_assertion(filename, env_function) do
        path = get_test_assertion_path(@assertions_test_result_dir, filename, env_function)
        File.read!("#{path}.tree") |> String.trim()
      rescue
        _ ->
          "__ENOENT__"
      end

      defp write_test_assertion_failure(html, filename, env_function) do
        path =
          get_test_assertion_path(@assertion_failures_test_result_dir, filename, env_function,
            mkdir: true
          )

        File.write!("#{path}.html", html)

        html_tree_string = create_html_tree_string(html)
        File.write!("#{path}.tree", html_tree_string)
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
        "#{dir}/#{filename}"
      end

      defp get_filename_from_function(env_function) do
        {test_name, _} = env_function

        test_name
        |> to_string()
        |> String.trim_leading("test ")
        |> String.replace(~r/[[:punct:][:space:]]/, "-")
        |> String.replace(~r/\-{2,}/, "-")
        |> String.trim()
        |> String.trim("-")
      end
    end
  end
end
