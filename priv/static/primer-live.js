"use strict";
(() => {
  // javascript/prompt.ts
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
})();
