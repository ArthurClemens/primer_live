import Config

config :phoenix, :json_library, Jason


if Mix.env() == :dev do
  esbuild = fn args ->
    [
      args: ~w(./js/primer_live --bundle) ++ args,
      cd: Path.expand("../assets", __DIR__),
      env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
    ]
  end

  config :esbuild,
    version: "0.12.15",
    css: esbuild.(~w(--outdir=../priv/static/ --external:/images/*))
end
