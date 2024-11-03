defmodule GithubWorkflows do
  @moduledoc """
  After updating this module, run:

      mix github_workflows.generate

  See https://hexdocs.pm/github_workflows_generator.
  """

  def get do
    %{
      "ci.yml" => ci_workflow()
    }
  end

  defp ci_workflow do
    [
      [
        name: "CI",
        on: [
          pull_request: [],
          push: [
            branches: ["main"]
          ]
        ],
        jobs: [
          compile: compile_job(),
          credo: credo_job(),
          deps_audit: deps_audit_job(),
          # dialyzer: dialyzer_job(),
          format: format_job(),
          hex_audit: hex_audit_job(),
          test: test_job(),
          unused_deps: unused_deps_job(),
          ci_status: ci_status_job()
        ]
      ]
    ]
  end

  defp compile_job do
    elixir_job("Install deps and compile",
      steps: [
        [
          name: "Install Elixir dependencies",
          env: [MIX_ENV: "test"],
          run: "mix deps.get"
        ],
        [
          name: "Compile",
          env: [MIX_ENV: "test"],
          run: "mix compile"
        ]
      ]
    )
  end

  defp credo_job do
    elixir_job("Credo",
      needs: :compile,
      steps: [
        [
          name: "Check code style",
          env: [MIX_ENV: "test"],
          run: "mix credo --strict"
        ]
      ]
    )
  end

  defp deps_audit_job do
    elixir_job("Deps audit",
      needs: :compile,
      steps: [
        [
          name: "Check for vulnerable Mix dependencies",
          env: [MIX_ENV: "test"],
          run: "mix deps.audit"
        ]
      ]
    )
  end

  defp elixir_job(name, opts) do
    needs = Keyword.get(opts, :needs)
    steps = Keyword.get(opts, :steps, [])
    services = Keyword.get(opts, :services, nil)

    job = [
      name: name,
      "runs-on": "${{ matrix.versions.runner-image }}",
      strategy: [
        "fail-fast": false,
        matrix: [
          versions: [
            [
              elixir: "1.17",
              otp: "27.0",
              "runner-image": "ubuntu-22.04"
            ]
          ]
        ]
      ]
    ]

    job =
      if services do
        Keyword.put(job, :services, services)
      else
        job
      end

    job =
      Keyword.put(
        job,
        :steps,
        [
          checkout_step(),
          [
            name: "Set up Elixir",
            uses: "erlef/setup-beam@v1",
            with: [
              "elixir-version": "${{ matrix.versions.elixir }}",
              "otp-version": "${{ matrix.versions.otp }}"
            ]
          ],
          [
            uses: "actions/cache@v3",
            with:
              [
                path: ~S"""
                _build
                deps
                """
              ] ++ cache_opts(prefix: "mix-${{ matrix.versions.runner-image }}")
          ]
        ] ++ steps
      )

    job =
      if needs do
        Keyword.put(job, :needs, needs)
      else
        job
      end

    job
  end

  defp format_job do
    elixir_job("Format",
      needs: :compile,
      steps: [
        [
          name: "Check Elixir formatting",
          env: [MIX_ENV: "test"],
          run: "mix format --check-formatted"
        ]
      ]
    )
  end

  defp hex_audit_job do
    elixir_job("Hex audit",
      needs: :compile,
      steps: [
        [
          name: "Check for retired Hex packages",
          env: [MIX_ENV: "test"],
          run: "mix hex.audit"
        ]
      ]
    )
  end

  defp test_job do
    env = [
      MIX_ENV: "test"
    ]

    elixir_job("Test",
      needs: :compile,
      steps: [
        [
          name: "Run tests",
          env: env,
          run: "mix test"
        ]
      ]
    )
  end

  defp unused_deps_job do
    elixir_job("Check unused deps",
      needs: :compile,
      steps: [
        [
          name: "Check for unused Mix dependencies",
          env: [MIX_ENV: "test"],
          run: "mix deps.unlock --check-unused"
        ]
      ]
    )
  end

  defp ci_status_job do
    elixir_job("CI status",
      needs: [
        :credo,
        :deps_audit,
        :format,
        :hex_audit,
        :unused_deps,
        :test
      ]
    )
  end

  # defp dialyzer_job do
  #   elixir_job("Dialyzer",
  #     needs: :compile,
  #     steps: [
  #       [
  #         name: "Restore PLT cache",
  #         uses: "actions/cache@v3",
  #         with:
  #           [
  #             path: "priv/plts"
  #           ] ++ cache_opts(prefix: "plt-${{ matrix.versions.runner-image }}")
  #       ],
  #       [
  #         name: "Create PLTs",
  #         env: [MIX_ENV: "test"],
  #         run: "mix dialyzer --plt"
  #       ],
  #       [
  #         name: "Run dialyzer",
  #         env: [MIX_ENV: "test"],
  #         run: "mix dialyzer"
  #       ]
  #     ]
  #   )
  # end

  defp checkout_step do
    [
      name: "Checkout",
      uses: "actions/checkout@v4"
    ]
  end

  defp cache_opts(opts) do
    prefix = Keyword.get(opts, :prefix)

    [
      key: "#{prefix}-${{ matrix.versions.otp }}-${{ matrix.versions.elixir }}-${{ github.sha }}",
      "restore-keys": ~s"""
      #{prefix}-
      """
    ]
  end
end
