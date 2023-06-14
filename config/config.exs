import Config

config :phoenix, :json_library, Jason
config :primer_live, env: Mix.env()
config :esbuild, :version, "0.16.4"
