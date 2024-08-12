import Config

config :phoenix, :json_library, Jason
config :primer_live, env: Mix.env()

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.17.11"
