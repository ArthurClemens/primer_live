
import { join } from "path";
import { getCssText, storeCssText } from "./shared"

const ORIGIN_PATH = "assets/node_modules/@primer/primitives/dist/css/functional/themes/light.css"
const DESTINATION_PATH = "assets/css/gen-themes-light.css"

const relativeOriginPath = join("../", ORIGIN_PATH);
const relativeDestinationPath = join("../", DESTINATION_PATH);

async function processFile(
  originPath: string,
  destinationPath: string
) {

  let text = getCssText(originPath);
  text = `
:root,
${text}`;

  storeCssText(destinationPath, text);
}

processFile(relativeOriginPath, relativeDestinationPath);
