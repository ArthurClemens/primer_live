"use strict";
(() => {
  // js/session.ts
  var Session = {
    mounted() {
      window.addEventListener(
        "phx:pl-session",
        (e) => fetch(`/api/pl-session?payload=${JSON.stringify(e.detail)}`, {
          method: "post"
        })
      );
    }
  };
  window.Session = Session;

  // js/prompt.ts
  function getCheckboxFromPromptContent(contentElement) {
    const root = contentElement == null ? void 0 : contentElement.closest("[data-prompt]");
    if (!root) {
      return null;
    }
    const checkbox = root.querySelector('input[type="checkbox"]');
    if (!checkbox) {
      return null;
    }
    return checkbox;
  }
  function getCheckboxFromSelectorOrElement(selectorOrElement) {
    let checkbox = null;
    if (typeof selectorOrElement === "string") {
      const element = document.querySelector(selectorOrElement);
      if (element) {
        checkbox = element.querySelector('input[type="checkbox"]');
      }
    } else {
      checkbox = getCheckboxFromPromptContent(selectorOrElement);
    }
    return checkbox;
  }
  function getElements(checkbox) {
    const root = checkbox.closest("[data-prompt]");
    if (!root) {
      throw new Error("Prompt element 'data-prompt' not found");
    }
    const wrapper = (root == null ? void 0 : root.querySelector("[data-prompt-content]")) || null;
    if (!wrapper) {
      throw new Error("Prompt element 'data-prompt-content' not found");
    }
    const content = wrapper == null ? void 0 : wrapper.querySelector("[data-content]");
    if (!content) {
      throw new Error("Prompt element 'data-content' not found");
    }
    const touchLayer = (wrapper == null ? void 0 : wrapper.querySelector("[data-touch]")) || null;
    const toggle = (root == null ? void 0 : root.querySelector("label")) || null;
    return {
      root,
      touchLayer,
      content,
      toggle
    };
  }
  function setCheckboxState({
    checkbox,
    state,
    elements,
    options
  }) {
    switch (state) {
      case "showing":
        delete checkbox.dataset.ishiding;
        if (options.willShow) {
          options.willShow(elements);
        }
        break;
      case "endShowing":
        if (options.didShow) {
          options.didShow(elements);
        }
        break;
      case "hiding":
        checkbox.checked = false;
        checkbox.dataset.ishiding = "true";
        if (options.willHide) {
          options.willHide(elements);
        }
        break;
      case "endHiding":
        delete checkbox.dataset.ishiding;
        if (options.didHide) {
          options.didHide(elements);
        }
        break;
      default:
        break;
    }
  }
  var Prompt = {
    init: function() {
      this.checkbox = getCheckboxFromPromptContent(this.el || void 0);
      if (this.checkbox) {
        this.checkbox.dataset.ismounted = "true";
      }
    },
    mounted: function() {
      this.init();
    },
    updated: function() {
      this.init();
    },
    change: function(checkbox, options = {}) {
      const elements = getElements(checkbox);
      checkbox.addEventListener("transitionend", function(evt) {
        setCheckboxState({ checkbox, state: checkbox.checked ? "endShowing" : "endHiding", elements, options });
      }, { once: true });
      setCheckboxState({ checkbox, state: checkbox.checked ? "showing" : "hiding", elements, options });
    },
    hide: function(selectorOrElement) {
      var _a;
      if (typeof selectorOrElement !== "string" && selectorOrElement.dataset.touch !== void 0) {
        const root = selectorOrElement.closest("[data-prompt]");
        if ((root == null ? void 0 : root.dataset.ismodal) !== void 0) {
          return;
        }
      }
      (_a = getCheckboxFromSelectorOrElement(selectorOrElement)) == null ? void 0 : _a.click();
    },
    show: function(selectorOrElement) {
      var _a;
      (_a = getCheckboxFromSelectorOrElement(selectorOrElement)) == null ? void 0 : _a.click();
    }
  };
  if (typeof window !== "undefined") {
    window.Prompt = Prompt;
  }
})();
