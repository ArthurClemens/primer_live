// javascript/prompt.ts
var Prompt = {
  mounted() {
    const el = this.el;
    const contentEl = el.querySelector("[data-content]");
    if (!(contentEl instanceof HTMLElement)) {
      console.error("Missing element with attribute [data-content]");
      return;
    }
    const pushEvent = (selector, status) => {
      var _a;
      (_a = this.pushEventTo) == null ? void 0 : _a.call(this, selector, "primer_live:prompt", {
        elementId: el.id,
        selector,
        status
      });
    };
    const createStatusHandler = (startStatus, endStatus) => {
      return (evt) => {
        const { selector, transitionDuration } = evt.detail;
        if (!selector) {
          console.error("Missing status_callback_selector");
          return;
        }
        pushEvent(selector, startStatus);
        setTimeout(() => {
          pushEvent(selector, endStatus);
        }, transitionDuration);
      };
    };
    this.handlePromptToggle = (evt) => {
      var _a;
      const cmd = el.classList.contains("is-open") ? el.dataset.close : el.dataset.open;
      if (cmd) {
        (_a = this.liveSocket) == null ? void 0 : _a.execJS(el, cmd);
      } else {
        console.error("No command found in element dataset");
      }
    };
    this.handlePromptOpen = createStatusHandler("opening", "opened");
    el.addEventListener("prompt:open", this.handlePromptOpen);
    this.handlePromptClose = createStatusHandler("closing", "closed");
    el.addEventListener("prompt:close", this.handlePromptClose);
    el.addEventListener("prompt:toggle", this.handlePromptToggle);
  },
  destroyed() {
    if (!this.el) {
      return;
    }
    if (this.handlePromptOpen) {
      this.el.removeEventListener("prompt:open", this.handlePromptOpen);
    }
    if (this.handlePromptClose) {
      this.el.removeEventListener("prompt:close", this.handlePromptClose);
    }
    if (this.handlePromptToggle) {
      this.el.removeEventListener("prompt:toggle", this.handlePromptToggle);
    }
  }
};
if (typeof window !== "undefined") {
  window.Prompt = Prompt;
}
window.addEventListener("keydown", maybeCloseFromEscapeKey);
function maybeCloseFromEscapeKey(evt) {
  if (evt.key === "Escape") {
    const openPrompts = Array.from(
      document.querySelectorAll("[data-prompt].is-open")
    ).filter((el) => el.dataset.isescapable !== void 0);
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
export {
  Prompt
};
//# sourceMappingURL=primer-live.esm.js.map
