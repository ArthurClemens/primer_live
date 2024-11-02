import esbuild, { BuildOptions } from "esbuild";
import { sassPlugin } from "esbuild-sass-plugin";
import { writeFileSync } from "fs";

declare var process: {
  argv: string[];
  env: {
    SCOPED: number;
  };
};

type OptsFromArgs = Partial<BuildOptions>;

/* Write a variables file that sets the $scoped variable for Sass */
writeFileSync("./css/gen-variables.scss", `$scoped: ${!!process.env.SCOPED};`, {
  flag: "w",
});

const args = process.argv.slice(2);

const ARGS_REGEXP = /^\s*--(?<key>\w+)\s*=?\s*(?<value>.*)$/;

const optsFromArgs: OptsFromArgs = args.reduce((acc, arg) => {
  const parts = arg.match(ARGS_REGEXP);
  if (parts !== null && parts.groups) {
    const key = parts.groups?.key;
    const value = parts.groups?.value !== "" ? parts.groups.value : true;
    return {
      ...acc,
      [key]: value,
    };
  }
  return acc;
}, {});

if (!optsFromArgs.outfile) {
  throw new Error(
    'Missing outfile. Are you running the build script outside of the mix command "assets.build"?'
  );
}

const entryPoints: string[] = ["index.ts"];

const config: BuildOptions = {
  ...optsFromArgs,
  entryPoints,
  bundle: true,
  target: "es2017",
  logLevel: "info",
  external: ["/images/*"],
  plugins: [sassPlugin()],
};

if (config.minify) {
  const minifyConfig: BuildOptions = {
    ...config,
    minify: true,
    target: ["es2020", "chrome58", "edge18", "firefox57", "node12", "safari11"],
  };

  esbuild.build(minifyConfig);
} else {
  esbuild.build(config);
}
