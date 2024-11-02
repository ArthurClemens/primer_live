import { join } from "path";
import * as fs from "fs";
import * as prettier from "prettier";
import yargs from "yargs/yargs";
import { hideBin } from "yargs/helpers";

declare var process: {
  argv: string[];
};

function getCssText(path: string) {
  return fs
    .readFileSync(path, {
      encoding: "utf8",
      flag: "r",
    })
    .toString();
}

function replaceTexts(text: string) {
  return text
  .replace(/:root/g, ":scope")
  .replace(/.__AMP__/g, "&");
}

function wrapInScope(text: string) {
  return `@scope (.primer-live) {
  ${text}
}`;
}

function storeCssText(path: string, data: string) {
  fs.writeFileSync(path, data, {
    flag: "w",
  });
}

type ProcessFileOpts = {
  prettify: boolean;
};

async function processFile(
  path: string,
  { prettify: prettify }: ProcessFileOpts
) {
  let text = getCssText(path);
  text = replaceTexts(text);
  text = wrapInScope(text);
  if (prettify) {
    text = await prettier.format(text, {
      parser: "css",
    });
  }
  storeCssText(path, text);
}

const argv = yargs(hideBin(process.argv))
  .option("file", {
    type: "string",
    demandOption: true,
    description: "CSS file path",
  })
  .option("prettify", {
    type: "boolean",
    default: false,
    description: "Whether to prettify the result",
  })
  .parseSync();

const relativeFilePath = join("../", argv.file);

processFile(relativeFilePath, { prettify: argv.prettify });
