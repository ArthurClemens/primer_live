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
var ROOT_SELECTOR = "[data-prompt]";
var WRAPPER_SELECTOR = "[data-prompt-content]";
var CONTENT_SELECTOR = "[data-content]";
var TOUCH_LAYER_SELECTOR = "[data-touch]";
var CHECKBOX_SELECTOR = 'input[type="checkbox"]';
var TOGGLE_SELECTOR = "label";
var IS_MOUNTED_DATA = "ismounted";
var TOUCH_DATA = "touch";
var IS_MODAL_DATA = "ismodal";
var IS_ESCAPABLE_DATA = "isescapable";
var FOCUS_FIRST_SELECTOR_DATA = "focusfirst";
var isTouchLayer = (el) => (el == null ? void 0 : el.dataset[TOUCH_DATA]) !== void 0;
var isModal = (el) => (el == null ? void 0 : el.dataset[IS_MODAL_DATA]) !== void 0;
var isEscapable = (el) => (el == null ? void 0 : el.dataset[IS_ESCAPABLE_DATA]) !== void 0;
function getCheckboxFromPromptContent(contentElement) {
  const root = contentElement == null ? void 0 : contentElement.closest(ROOT_SELECTOR);
  if (!root) {
    return null;
  }
  const checkbox = root.querySelector(CHECKBOX_SELECTOR);
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
      checkbox = element.querySelector(CHECKBOX_SELECTOR);
    }
  } else {
    checkbox = getCheckboxFromPromptContent(selectorOrElement);
  }
  return checkbox;
}
function getElements(checkbox) {
  const root = checkbox.closest(ROOT_SELECTOR);
  if (!root) {
    throw new Error(`Prompt element ${ROOT_SELECTOR} not found`);
  }
  const wrapper = (root == null ? void 0 : root.querySelector(WRAPPER_SELECTOR)) || null;
  if (!wrapper) {
    throw new Error("Prompt element 'data-prompt-content' not found");
  }
  const content = wrapper == null ? void 0 : wrapper.querySelector(CONTENT_SELECTOR);
  if (!content) {
    throw new Error(`Prompt element ${CONTENT_SELECTOR} not found`);
  }
  const touchLayer = (wrapper == null ? void 0 : wrapper.querySelector(TOUCH_LAYER_SELECTOR)) || null;
  const toggle = (root == null ? void 0 : root.querySelector(TOGGLE_SELECTOR)) || null;
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
  options,
  onEndShowing
}) {
  switch (state) {
    case "showing":
      delete checkbox.dataset.ishiding;
      if (options.willShow) {
        options.willShow(elements);
      }
      break;
    case "endShowing":
      if (onEndShowing) {
        onEndShowing(elements);
      }
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
function closeFromTouchLayer(evt) {
  var _a;
  if (!evt.target) {
    return;
  }
  const touchLayer = evt.target;
  if (touchLayer && touchLayer instanceof HTMLElement && !isTouchLayer(touchLayer)) {
    return;
  }
  const root = touchLayer.closest(ROOT_SELECTOR);
  if (root && root instanceof HTMLElement && isModal(root)) {
    return;
  }
  (_a = getCheckboxFromSelectorOrElement(touchLayer)) == null ? void 0 : _a.click();
}
function closeFromEscapeKey(evt) {
  if (evt.key === "Escape") {
    const openPromptCheckboxes = Array.from(
      document.querySelectorAll(
        `${ROOT_SELECTOR} > ${CHECKBOX_SELECTOR}:checked`
      )
    );
    const topCheckbox = openPromptCheckboxes.reverse()[0];
    if (topCheckbox instanceof HTMLElement) {
      const root = topCheckbox.closest(ROOT_SELECTOR);
      if (isEscapable(root)) {
        topCheckbox.click();
      }
    }
  }
}
function onShow({ root }) {
  const content = root.querySelector(CONTENT_SELECTOR);
  if (!content) {
    return;
  }
  handleFocus(root, content);
}
function handleFocus(root, content) {
  const focusFirstSelector = root.dataset[FOCUS_FIRST_SELECTOR_DATA];
  if (focusFirstSelector) {
    const firstFocusable = content.querySelector(focusFirstSelector);
    if (firstFocusable) {
      firstFocusable.focus();
    }
  }
}
function onClick(selectorOrElement, options) {
  const checkbox = getCheckboxFromSelectorOrElement(selectorOrElement);
  if (checkbox) {
    if (options) {
      checkbox.options = options;
    }
    checkbox.click();
  }
}
var Prompt = {
  isInited: false,
  init: function() {
    const checkbox = getCheckboxFromPromptContent(this.el || void 0);
    if (checkbox) {
      checkbox.dataset[IS_MOUNTED_DATA] = "true";
    }
    if (!Prompt.isInited) {
      window.addEventListener("keydown", closeFromEscapeKey);
      Prompt.isInited = true;
    }
  },
  mounted: function() {
    this.init();
  },
  updated: function() {
    this.init();
  },
  change: function(selectorOrElement, options = {}) {
    var _a, _b;
    const checkbox = getCheckboxFromSelectorOrElement(selectorOrElement);
    if (!checkbox || !(checkbox instanceof HTMLInputElement)) {
      return;
    }
    const elements = getElements(checkbox);
    if (checkbox.checked) {
      (_a = elements.touchLayer) == null ? void 0 : _a.addEventListener("click", closeFromTouchLayer);
    } else {
      (_b = elements.touchLayer) == null ? void 0 : _b.removeEventListener("click", closeFromTouchLayer);
    }
    checkbox.addEventListener(
      "transitionend",
      function(evt) {
        setCheckboxState({
          checkbox,
          state: checkbox.checked ? "endShowing" : "endHiding",
          elements,
          options,
          onEndShowing: onShow
        });
      },
      { once: true }
    );
    setCheckboxState({
      checkbox,
      state: checkbox.checked ? "showing" : "hiding",
      elements,
      options
    });
  },
  hide: function(selectorOrElement) {
    if (typeof selectorOrElement !== "string") {
      let element = selectorOrElement;
      const root = element.closest(ROOT_SELECTOR);
      if (isTouchLayer(element)) {
        if (isModal(root)) {
          return;
        }
      }
    }
    onClick(selectorOrElement);
  },
  show: onClick
};
if (typeof window !== "undefined") {
  window.Prompt = Prompt;
}
export {
  Prompt,
  Session
};
//# sourceMappingURL=primer-live.esm.js.map
