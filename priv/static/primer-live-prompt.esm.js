var __defProp = Object.defineProperty;
var __defProps = Object.defineProperties;
var __getOwnPropDescs = Object.getOwnPropertyDescriptors;
var __getOwnPropSymbols = Object.getOwnPropertySymbols;
var __hasOwnProp = Object.prototype.hasOwnProperty;
var __propIsEnum = Object.prototype.propertyIsEnumerable;
var __defNormalProp = (obj, key, value) => key in obj ? __defProp(obj, key, { enumerable: true, configurable: true, writable: true, value }) : obj[key] = value;
var __spreadValues = (a, b) => {
  for (var prop in b || (b = {}))
    if (__hasOwnProp.call(b, prop))
      __defNormalProp(a, prop, b[prop]);
  if (__getOwnPropSymbols)
    for (var prop of __getOwnPropSymbols(b)) {
      if (__propIsEnum.call(b, prop))
        __defNormalProp(a, prop, b[prop]);
    }
  return a;
};
var __spreadProps = (a, b) => __defProps(a, __getOwnPropDescs(b));

// node_modules/dialogic-js/dist/dialogic-js.js
var wait = (m) => new Promise((r) => setTimeout(r, m));
var getPropertyValue = (style, props) => props.reduce((acc, prop) => {
  if (acc !== "0s") {
    return acc;
  }
  return style.getPropertyValue(prop);
}, "0s");
var getStyleValue = ({
  domElement,
  props
}) => {
  const defaultView = document.defaultView;
  if (defaultView) {
    const style = defaultView.getComputedStyle(domElement);
    if (style) {
      return getPropertyValue(style, props);
    }
  }
  return void 0;
};
var styleDurationToMs = (durationStr) => {
  const parsed = parseFloat(durationStr) * (durationStr.indexOf("ms") === -1 ? 1e3 : 1);
  return Number.isNaN(parsed) ? 0 : parsed;
};
var getDuration = (domElement) => {
  const durationStyleValue = getStyleValue({
    domElement,
    props: ["animation-duration", "transition-duration"]
  });
  const durationValue = durationStyleValue !== void 0 ? styleDurationToMs(durationStyleValue) : 0;
  const delayStyleValue = getStyleValue({
    domElement,
    props: ["animation-delay", "transition-delay"]
  });
  const delayValue = delayStyleValue !== void 0 ? styleDurationToMs(delayStyleValue) : 0;
  return durationValue + delayValue;
};
var repaint = (element) => element.scrollTop;
var isVisible = (element) => {
  const style = typeof window !== "undefined" ? window.getComputedStyle(element) : {};
  if (style.opacity === "0" || style.display === "none") {
    return false;
  }
  return !!(element.offsetWidth || element.offsetHeight || element.getClientRects().length);
};
var isFocusable = (el, interactiveOnly) => {
  return el instanceof HTMLAnchorElement && el.rel !== "ignore" || el instanceof HTMLAreaElement && el.href !== void 0 || [
    HTMLInputElement,
    HTMLSelectElement,
    HTMLTextAreaElement,
    HTMLButtonElement
  ].some((elClass) => el instanceof elClass) && !el.disabled || el instanceof HTMLIFrameElement || el.tabIndex > 0 || !interactiveOnly && el.tabIndex === 0 && el.getAttribute("tabindex") !== null && el.getAttribute("aria-hidden") !== "true";
};
var getFirstFocusable = (content) => {
  const focusable = [].slice.call(
    content.querySelectorAll(
      "button, [href], input, select, textarea, [tabindex]:not([tabindex='-1'])"
    )
  ).filter((el) => isFocusable(el, true)).sort((a, b) => a.tabIndex - b.tabIndex);
  return focusable[0];
};
var storeDataset = (cache, id, dataset) => {
  if (!id) return;
  if (!cache[id]) {
    cache[id] = JSON.stringify(dataset);
  }
};
var readDataset = (cache, id) => {
  if (!id) return;
  return JSON.parse(cache[id]);
};
var clearDataset = (cache, id) => {
  if (!id) return;
  delete cache[id];
};
var applyDataset = (dataset, el) => {
  if (!el || !dataset) return;
  Object.keys(dataset).forEach((key) => {
    el.dataset[key] = dataset[key];
  });
};
var ROOT_SELECTOR = "[data-prompt]";
var CONTENT_SELECTOR = "[data-content]";
var TOUCH_SELECTOR = "[data-touch]";
var BACKDROP_SELECTOR = "[data-backdrop]";
var TOGGLE_SELECTOR = "[data-toggle]";
var IS_MODAL_DATA = "ismodal";
var IS_ESCAPABLE_DATA = "isescapable";
var IS_FOCUS_FIRST_DATA = "isfocusfirst";
var FOCUS_FIRST_SELECTOR_DATA = "focusfirst";
var IS_OPEN_DATA = "isopen";
var IS_LOCKED_DATA = "islocked";
var LOCK_DURATION = 300;
var INITIAL_STATUS = {
  isOpen: false,
  willShow: false,
  didShow: false,
  willHide: false,
  didHide: false
};
var hideView = async (elements, options = {}) => {
  var _a, _b, _c, _d;
  const { prompt, content, root, isDetails, isEscapable, escapeListener } = elements;
  if (root.dataset[IS_LOCKED_DATA] !== void 0 && !options.isIgnoreLockDuration) {
    return;
  }
  prompt.status = __spreadProps(__spreadValues({}, INITIAL_STATUS), {
    isOpen: true,
    // still open while hiding
    willHide: true
  });
  (_a = options.willHide) == null ? void 0 : _a.call(options, elements);
  (_b = options.getStatus) == null ? void 0 : _b.call(options, prompt.status);
  delete root.dataset[IS_OPEN_DATA];
  const duration = getDuration(content);
  await wait(duration);
  if (isDetails) {
    root.removeAttribute("open");
  }
  if (content.tagName == "DIALOG") {
    const dialog = content;
    dialog.close();
    repaint(content);
  }
  prompt.status = __spreadProps(__spreadValues({}, INITIAL_STATUS), {
    didHide: true
  });
  (_c = options.getStatus) == null ? void 0 : _c.call(options, prompt.status);
  (_d = options.didHide) == null ? void 0 : _d.call(options, elements);
  if (isEscapable && typeof window !== "undefined") {
    window.removeEventListener("keydown", escapeListener);
  }
};
var showView = async (elements, options = {}) => {
  var _a, _b, _c, _d;
  const {
    prompt,
    content,
    root,
    isDetails,
    isEscapable,
    isFocusFirst,
    focusFirstSelector,
    escapeListener
  } = elements;
  if (root.dataset[IS_LOCKED_DATA] !== void 0) {
    return;
  }
  root.dataset[IS_LOCKED_DATA] = "";
  setTimeout(() => {
    if (root) {
      delete root.dataset[IS_LOCKED_DATA];
    }
  }, LOCK_DURATION);
  if (isEscapable && typeof window !== "undefined") {
    window.addEventListener("keydown", escapeListener);
  }
  if (isDetails) {
    root.setAttribute("open", "");
    repaint(root);
  }
  root.dataset[IS_OPEN_DATA] = "";
  repaint(root);
  prompt.status = __spreadProps(__spreadValues({}, INITIAL_STATUS), {
    willShow: true
  });
  (_a = options.willShow) == null ? void 0 : _a.call(options, elements);
  (_b = options.getStatus) == null ? void 0 : _b.call(options, prompt.status);
  const duration = getDuration(content);
  await wait(duration);
  if (isFocusFirst) {
    const firstFocusable = getFirstFocusable(content);
    if (firstFocusable) {
      firstFocusable.focus();
    }
  } else if (focusFirstSelector) {
    const firstFocusable = content.querySelector(focusFirstSelector);
    if (firstFocusable) {
      firstFocusable.focus();
    }
  }
  prompt.status = __spreadProps(__spreadValues({}, INITIAL_STATUS), {
    didShow: true,
    isOpen: true
  });
  (_c = options.didShow) == null ? void 0 : _c.call(options, elements);
  (_d = options.getStatus) == null ? void 0 : _d.call(options, prompt.status);
};
var toggleView = async (elements, mode = 2, options) => {
  switch (mode) {
    case 0:
      return await showView(elements, options);
    case 1:
      return await hideView(elements, options);
    default: {
      if (isVisible(elements.content)) {
        return await hideView(elements, options);
      } else {
        return await showView(elements, options);
      }
    }
  }
};
var getElements = (prompt, promptElement, command, options) => {
  let root = null;
  if (!command && promptElement) {
    root = promptElement;
  } else if (typeof command === "string") {
    root = document.querySelector(command);
  } else if (command && !!command.tagName) {
    root = command.closest(ROOT_SELECTOR);
  }
  if (!root) {
    console.error("Prompt element 'data-prompt' not found");
    return void 0;
  }
  const content = root.querySelector(CONTENT_SELECTOR);
  if (!content) {
    console.error("Prompt element 'data-content' not found");
    return void 0;
  }
  const toggle = root.querySelector(TOGGLE_SELECTOR) || root.querySelector("summary");
  const touchLayer = root.querySelector(TOUCH_SELECTOR);
  const backdropLayer = root.querySelector(BACKDROP_SELECTOR);
  const isDetails = root.tagName === "DETAILS";
  const isModal = root.dataset[IS_MODAL_DATA] !== void 0;
  const isEscapable = root.dataset[IS_ESCAPABLE_DATA] !== void 0;
  const isFocusFirst = root.dataset[IS_FOCUS_FIRST_DATA] !== void 0;
  const focusFirstSelector = root.dataset[FOCUS_FIRST_SELECTOR_DATA];
  const elements = {
    prompt,
    root,
    isDetails,
    isModal,
    isEscapable,
    isFocusFirst,
    focusFirstSelector,
    toggle,
    content,
    touchLayer,
    backdropLayer,
    escapeListener: function(e) {
      if (e.key === "Escape") {
        const prompts = [].slice.call(
          document.querySelectorAll(`${ROOT_SELECTOR}[data-${IS_OPEN_DATA}]`)
        );
        const topElement = prompts.reverse()[0];
        if (topElement === elements.root) {
          hideView(elements, __spreadProps(__spreadValues({}, options), { isIgnoreLockDuration: true }));
        }
      }
    },
    clickTouchLayerListener: function(e) {
      if (e.target !== touchLayer) {
        return;
      }
      if (!isModal) {
        toggleView(elements, 1, options);
      }
    },
    clickToggleListener: function(e) {
      e.preventDefault();
      e.stopPropagation();
      toggleView(elements, void 0, options);
    }
  };
  return elements;
};
var initToggleEvents = (elements) => {
  const { toggle, clickToggleListener } = elements;
  if (toggle && toggle.dataset.registered !== "") {
    toggle.addEventListener("click", clickToggleListener);
    toggle.dataset.registered = "";
  }
};
var initTouchEvents = (elements) => {
  const { clickTouchLayerListener, touchLayer } = elements;
  if (touchLayer && touchLayer.dataset.registered !== "") {
    touchLayer.addEventListener("click", clickTouchLayerListener);
    touchLayer.dataset.registered = "";
  }
};
async function init(prompt, command, options, mode) {
  prompt.options = __spreadValues(__spreadValues({}, prompt.options), options);
  const elements = getElements(prompt, prompt.el, command, prompt.options);
  if (elements === void 0) {
    return;
  }
  if (!prompt.el) {
    prompt.el = elements == null ? void 0 : elements.root;
  }
  const { root, content, isDetails, backdropLayer } = elements;
  if (options == null ? void 0 : options.transitionDuration) {
    content.style.setProperty(
      "--prompt-transition-duration-content",
      `${options.transitionDuration}ms`
    );
    content.style.setProperty(
      "--prompt-fast-transition-duration-content",
      `${options.transitionDuration}ms`
    );
    if (backdropLayer) {
      backdropLayer.style.setProperty(
        "--prompt-transition-duration-backdrop",
        `${options.transitionDuration}ms`
      );
      backdropLayer.style.setProperty(
        "--prompt-fast-transition-duration-backdrop",
        `${options.transitionDuration}ms`
      );
    }
  }
  if (content.tagName == "DIALOG") {
    const dialog = content;
    dialog.show();
    repaint(content);
  }
  initToggleEvents(elements);
  initTouchEvents(elements);
  const isOpen = isDetails && root.getAttribute("open") !== null;
  if (isOpen && mode !== 1) {
    showView(elements, prompt.options);
  }
  if (mode !== void 0) {
    await toggleView(elements, mode, prompt.options);
  }
}
var Prompt = {
  _cache: {},
  mounted() {
  },
  beforeUpdate() {
    var _a, _b;
    storeDataset(this._cache, (_a = this.el) == null ? void 0 : _a.id, (_b = this.el) == null ? void 0 : _b.dataset);
  },
  updated() {
    var _a, _b;
    const dataset = readDataset(this._cache, (_a = this.el) == null ? void 0 : _a.id);
    applyDataset(dataset, this.el);
    clearDataset(this._cache, (_b = this.el) == null ? void 0 : _b.id);
  },
  destroyed() {
    var _a;
    clearDataset(this._cache, (_a = this.el) == null ? void 0 : _a.id);
  },
  status: INITIAL_STATUS,
  async init(command, options) {
    await init(this, command, options);
  },
  async toggle(command, options) {
    await init(
      this,
      command,
      options,
      2
      /* TOGGLE */
    );
  },
  async show(command, options) {
    await init(
      this,
      command,
      options,
      0
      /* SHOW */
    );
  },
  async hide(command, options) {
    await init(
      this,
      command,
      options,
      1
      /* HIDE */
    );
  }
};
if (typeof window !== "undefined") {
  window.Prompt = Prompt;
}

// js/prompt.ts
function handleToggleEvent(event) {
  const target = event.target;
  if (!(target instanceof HTMLElement)) {
    return;
  }
  const actionDispatch = {
    show: Prompt.show,
    hide: Prompt.hide
  };
  const action = event.detail.action;
  const transitionDuration = event.detail.transitionDuration;
  const options = {
    transitionDuration
  };
  if (action) {
    actionDispatch[action](target, options);
  }
}
window.addEventListener("prompt:toggle", handleToggleEvent);
export {
  Prompt
};
//# sourceMappingURL=primer-live-prompt.esm.js.map
