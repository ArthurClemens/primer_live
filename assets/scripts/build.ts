import esbuild, { BuildOptions } from 'esbuild';
import { sassPlugin } from 'esbuild-sass-plugin';

declare var process: {
  argv: string[];
};

type OptsFromArgs = Partial<BuildOptions>;

const args = process.argv.slice(2);

const argRe = /^\s*--(?<key>\w+)\s*=?\s*(?<value>.*)$/;

const optsFromArgs: OptsFromArgs = args.reduce((acc, arg) => {
  const parts = arg.match(argRe);
  if (parts !== null && parts.groups) {
    const key = parts.groups?.key;
    const value = parts.groups?.value !== '' ? parts.groups.value : true;
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

const entryPoints: string[] = [];
if (optsFromArgs.format === 'esm' || optsFromArgs.format === 'cjs') {
  entryPoints.push('index-js-only.ts');
} else {
  entryPoints.push('index.ts');
}

const config: BuildOptions = {
  ...optsFromArgs,
  entryPoints,
  bundle: true,
  target: 'es2017',
  logLevel: 'info',
  external: ['/images/*'],
  plugins: [sassPlugin()],
};

if (config.minify) {
  const minifyConfig: BuildOptions = {
    ...config,
    minify: true,
    target: ['es2020', 'chrome58', 'edge18', 'firefox57', 'node12', 'safari11'],
  };

  esbuild.build(minifyConfig);
} else {
  esbuild.build(config);
}
