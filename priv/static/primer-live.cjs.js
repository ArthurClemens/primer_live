"use strict";
var __defProp = Object.defineProperty;
var __getOwnPropDesc = Object.getOwnPropertyDescriptor;
var __getOwnPropNames = Object.getOwnPropertyNames;
var __hasOwnProp = Object.prototype.hasOwnProperty;
var __export = (target, all) => {
  for (var name in all)
    __defProp(target, name, { get: all[name], enumerable: true });
};
var __copyProps = (to, from, except, desc) => {
  if (from && typeof from === "object" || typeof from === "function") {
    for (let key of __getOwnPropNames(from))
      if (!__hasOwnProp.call(to, key) && key !== except)
        __defProp(to, key, { get: () => from[key], enumerable: !(desc = __getOwnPropDesc(from, key)) || desc.enumerable });
  }
  return to;
};
var __toCommonJS = (mod) => __copyProps(__defProp({}, "__esModule", { value: true }), mod);

// index.ts
var index_exports = {};
__export(index_exports, {
  Prompt: () => Prompt
});
module.exports = __toCommonJS(index_exports);

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
//# sourceMappingURL=primer-live.cjs.js.map
