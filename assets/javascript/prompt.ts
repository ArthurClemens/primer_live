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
