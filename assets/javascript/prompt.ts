import { ViewHook } from "phoenix_live_view";

/**
Prompt Hook handles status callbacks.
*/
export type TPrompt = Partial<ViewHook> & {
  handlePromptOpen?: (evt: CustomEvent) => void;
  handlePromptClose?: (evt: CustomEvent) => void;
};

export const Prompt: TPrompt = {
  mounted() {
    const el = this.el as HTMLElement;
    const contentEl = el.querySelector("[data-content]");

    if (!(contentEl instanceof HTMLElement)) {
      console.error("Missing element with attribute [data-content]");
      return;
    }

    const pushEvent = (selector: string, status: string) => {
      this.pushEventTo?.(selector, "primer_live:prompt", {
        elementId: el.id,
        selector: selector,
        status: status,
      });
    };

    const createStatusHandler = (startStatus: string, endStatus: string) => {
      return (evt: CustomEvent) => {
        const selector = evt.detail.selector;
        if (!selector) {
          console.error("Missing status_callback_selector");
          return;
        }

        pushEvent(selector, startStatus);

        contentEl.addEventListener(
          "transitionend",
          function (_evt) {
            pushEvent(selector, endStatus);
          },
          { once: true },
        );
      };
    };

    this.handlePromptOpen = createStatusHandler("opening", "opened");
    el.addEventListener("prompt:open", this.handlePromptOpen);

    this.handlePromptClose = createStatusHandler("closing", "closed");
    el.addEventListener("prompt:close", this.handlePromptClose);
  },
};

declare global {
  interface Window {
    Prompt: TPrompt;
  }
}

if (typeof window !== "undefined") {
  window.Prompt = Prompt;
}

/**
Handle closing prompts using the Escape key. The listener function ensures that only
the top prompt is closed, so stacked prompts can be closed one by one.
*/

window.addEventListener("keydown", maybeCloseFromEscapeKey);

function maybeCloseFromEscapeKey(evt: KeyboardEvent) {
  if (evt.key === "Escape") {
    // Only close the top element if its root dataset contains "is escapable" data attr
    const openPrompts = Array.from(
      document.querySelectorAll<HTMLElement>("[data-prompt].is-open"),
    ).filter((el) => el.dataset.isescapable !== undefined);

    let topOpenPrompt = openPrompts.reverse()[0];
    if (!(topOpenPrompt instanceof HTMLElement)) {
      return;
    }

    openPrompts.forEach((el) => {
      const focusWrapEl = el.querySelector("[data-focuswrap]");
      if (focusWrapEl instanceof HTMLElement) {
        const keyName = el == topOpenPrompt ? "Escape" : "Escape_disabled";
        focusWrapEl.setAttribute("phx-key", keyName);
      }
    });
  }
}
