import * as fs from "fs";

export function getCssText(path: string) {
  return fs
    .readFileSync(path, {
      encoding: "utf8",
      flag: "r",
    })
    .toString();
}

export function storeCssText(path: string, data: string) {
  fs.writeFileSync(path, data, {
    flag: "w",
  });
}