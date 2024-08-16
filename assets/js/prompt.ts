export * from "dialogic-js";
import { Prompt, Options } from "dialogic-js";

/*
CustomEvent expects detail to contain:
- action: "show" | "hide" (required)
- transitionDuration: number (optional)
*/
function handleToggleEvent(event: CustomEvent) {
  const target: EventTarget | null = event.target;
  if (!(target instanceof HTMLElement)) {
    return;
  }

  const actionDispatch = {
    show: Prompt.show,
    hide: Prompt.hide,
  };

  const action: "show" | "hide" = event.detail.action;

  const transitionDuration: number | undefined =
    event.detail.transitionDuration;

  const options: Options = {
    transitionDuration,
  };

  if (action) {
    actionDispatch[action](target, options);
  }
}

window.addEventListener("prompt:toggle", handleToggleEvent);
