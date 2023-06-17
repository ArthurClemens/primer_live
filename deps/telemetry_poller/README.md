# telemetry_poller

[![Codecov](https://codecov.io/gh/beam-telemetry/telemetry_poller/branch/master/graphs/badge.svg)](https://codecov.io/gh/beam-telemetry/telemetry_poller/branch/master/graphs/badge.svg)

Allows to periodically collect measurements and dispatch them as Telemetry events.

`telemetry_poller` by default runs a poller to perform VM measurements:

  * `[vm, memory]` - contains the total memory, process memory, and all other keys in `erlang:memory/0`
  * `[vm, total_run_queue_lengths]` - returns the run queue lengths for CPU and IO schedulers. It contains the `total`, `cpu` and `io` measurements
  * `[vm, system_counts]` - returns the current process, atom and port count as per `erlang:system_info/1`

You can directly consume those events after adding `telemetry_poller` as a dependency.

Poller also provides a convenient API for running custom pollers.

## Defining custom measurements

Poller also includes conveniences for performing process-based measurements as well as custom ones.

### Erlang

First define the poller with the custom measurements. The first measurement is the built-in `process_info` measurement and the second one is given by a custom module-function-args defined  by you:

```erlang
telemetry_poller:start_link(
  [{measurements, [
    {process_info, [{name, my_app_worker}, {event, [my_app, worker]}, {keys, [memory, message_queue_len]}]},
    {example_app_measurements, dispatch_session_count, []}
  ]},
  {period, timer:seconds(10)}, % configure sampling period - default is timer:seconds(5)
  {name, my_app_poller}
]).
```

Now define the custom measurement and you are good to go:

```erlang
-module(example_app_measurements).

dispatch_session_count() ->
    % emit a telemetry event when called
    telemetry:execute([example_app, session_count], #{count => example_app:session_count()}, #{}).
```

### Elixir

First define the poller with the custom measurements. The first measurement is the built-in `process_info` measurement and the second one is given by a custom module-function-args defined  by you:

```elixir
defmodule ExampleApp.Measurements do
  def dispatch_session_count() do
    # emit a telemetry event when called
    :telemetry.execute([:example_app, :session_count], %{count: ExampleApp.session_count()}, %{})
  end
end
```

```elixir
:telemetry_poller.start_link(
  # include custom measurement as an MFA tuple
  measurements: [
    {:process_info, name: :my_app_worker, event: [:my_app, :worker], keys: [:message, :message_queue_len]},
    {ExampleApp.Measurements, :dispatch_session_count, []},
  ],
  period: :timer.seconds(10), # configure sampling period - default is :timer.seconds(5)
  name: :my_app_poller
)
```

## Documentation

See [documentation](https://hexdocs.pm/telemetry_poller/) for more concrete examples and usage
instructions.

## Copyright and License

telemetry_poller is copyright (c) 2018 Chris McCord and Erlang Solutions.

telemetry_poller source code is released under Apache License, Version 2.0.

See [LICENSE](LICENSE) and [NOTICE](NOTICE) files for more information.
