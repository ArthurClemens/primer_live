type MaybeHTMLElement = HTMLElement | null;
type MaybePromptCheckbox = PromptCheckbox | null;

type PromptCheckbox = {
  options?: PromptOptions;
} & HTMLInputElement;

type PromptElements = {
  root: HTMLElement;
  content: HTMLElement;
  touchLayer?: MaybeHTMLElement;
  toggle?: MaybeHTMLElement;
};

type PromptOptions = {
  willShow?: (elements?: PromptElements) => void;
  didShow?: (elements?: PromptElements) => void;
  willHide?: (elements?: PromptElements) => void;
  didHide?: (elements?: PromptElements) => void;
};

type PromptState = "showing" | "endShowing" | "hiding" | "endHiding";

const ROOT_SELECTOR = "[data-prompt]";
const WRAPPER_SELECTOR = "[data-prompt-content]";
const CONTENT_SELECTOR = "[data-content]";
const TOUCH_LAYER_SELECTOR = "[data-touch]";
const CHECKBOX_SELECTOR = 'input[type="checkbox"]';
const TOGGLE_SELECTOR = "label";
const IS_MOUNTED_DATA = "ismounted";
const TOUCH_DATA = "touch";
const IS_MODAL_DATA = "ismodal";
const IS_ESCAPABLE_DATA = "isescapable";
const FOCUS_FIRST_SELECTOR_DATA = "focusfirst";

const isTouchLayer = (el?: MaybeHTMLElement) => el?.dataset[TOUCH_DATA] !== undefined;
const isModal = (el?: MaybeHTMLElement) => el?.dataset[IS_MODAL_DATA] !== undefined;
const isEscapable = (el?: MaybeHTMLElement) => el?.dataset[IS_ESCAPABLE_DATA] !== undefined;

function getCheckboxFromPromptContent(contentElement?: HTMLElement) {
  const root = contentElement?.closest(ROOT_SELECTOR);
  if (!root) {
    return null;
  }
  const checkbox: MaybePromptCheckbox = root.querySelector(CHECKBOX_SELECTOR);
  if (!checkbox) {
    return null;
  }
  return checkbox;
}

function getCheckboxFromSelectorOrElement(
  selectorOrElement: string | HTMLElement
) {
  let checkbox: HTMLInputElement | null = null;
  if (typeof selectorOrElement === "string") {
    const element: MaybeHTMLElement = document.querySelector(selectorOrElement);
    if (element) {
      checkbox = element.querySelector(CHECKBOX_SELECTOR);
    }
  } else {
    checkbox = getCheckboxFromPromptContent(selectorOrElement);
  }
  return checkbox;
}

function getElements(checkbox: HTMLInputElement): PromptElements {
  const root: MaybeHTMLElement = checkbox.closest(ROOT_SELECTOR);

  if (!root) {
    throw new Error(`Prompt element ${ROOT_SELECTOR} not found`);
  }

  const wrapper: MaybeHTMLElement =
    root?.querySelector(WRAPPER_SELECTOR) || null;
  if (!wrapper) {
    throw new Error("Prompt element 'data-prompt-content' not found");
  }

  const content: MaybeHTMLElement = wrapper?.querySelector(CONTENT_SELECTOR);
  if (!content) {
    throw new Error(`Prompt element ${CONTENT_SELECTOR} not found`);
  }

  const touchLayer: MaybeHTMLElement =
    wrapper?.querySelector(TOUCH_LAYER_SELECTOR) || null;
  const toggle: MaybeHTMLElement = root?.querySelector(TOGGLE_SELECTOR) || null;

  return {
    root,
    touchLayer,
    content,
    toggle,
  };
}

function setCheckboxState({
  checkbox,
  state,
  elements,
  options,
  onDidShow,
}: {
  checkbox: HTMLInputElement;
  state: PromptState;
  elements: PromptElements;
  options: PromptOptions;
  onDidShow?: (elements: PromptElements) => void;
}) {
  switch (state) {
    case "showing":
      delete checkbox.dataset.ishiding;
      if (options.willShow) {
        options.willShow(elements);
      }
      break;
    case "endShowing":
      if (onDidShow) {
        onDidShow(elements);
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

function closeFromTouchLayer(evt: MouseEvent) {
  if (!evt.target) {
    return;
  }
  const touchLayer: HTMLElement = evt.target as HTMLElement;
  if (touchLayer && touchLayer instanceof HTMLElement && !isTouchLayer(touchLayer)) {
    return;
  }
  const root = touchLayer.closest(ROOT_SELECTOR);
  if (root && root instanceof HTMLElement && isModal(root)) {
    return;
  }
  getCheckboxFromSelectorOrElement(touchLayer)?.click();
}

function closeFromEscapeKey(evt: KeyboardEvent) {
  if (evt.key === "Escape") {
    // Only close the top element if its root dataset contains "is escapable" data attr
    const openPromptCheckboxes = Array.from(
      document.querySelectorAll(
        `${ROOT_SELECTOR} > ${CHECKBOX_SELECTOR}:checked`
      )
    );
    const topCheckbox = openPromptCheckboxes.reverse()[0];

    if (topCheckbox instanceof HTMLElement) {
      const root: MaybeHTMLElement = topCheckbox.closest(ROOT_SELECTOR);
      if (isEscapable(root)) {
        topCheckbox.click();
      }
    }
  }
}

function onEndShowing({ root }: PromptElements) {
  const content: MaybeHTMLElement = root.querySelector(CONTENT_SELECTOR);
  if (!content) {
    return;
  }
  handleFocus(root, content)
}

function handleFocus(root: HTMLElement, content: HTMLElement) {
  const focusFirstSelector = root.dataset[FOCUS_FIRST_SELECTOR_DATA];
  if (focusFirstSelector) {
    const firstFocusable: HTMLElement | null =
      content.querySelector(focusFirstSelector);
    if (firstFocusable) {
      firstFocusable.focus();
    }
  }
}

function onToggle(
  selectorOrElement: string | HTMLElement,
  mode: 'show' | 'hide' | 'toggle',
  options?: PromptOptions
) {
  const checkbox: MaybePromptCheckbox =
    getCheckboxFromSelectorOrElement(selectorOrElement);
  if (checkbox) {
    if (checkbox.checked && mode === "show") {
      return;
    }
    if (!checkbox.checked && mode === "hide") {
      return;
    }
    if (options) {
      checkbox.options = options;
    }
    checkbox.click();
  }
}

type TPrompt = {
  el?: MaybeHTMLElement;
  checkbox?: MaybePromptCheckbox;
  isInited: boolean;
  init: () => void;
  mounted: () => void;
  updated: () => void;
  hide: (selectorOrElement: string | HTMLElement) => void;
  show: (selectorOrElement: string | HTMLElement) => void;
  toggle: (selectorOrElement: string | HTMLElement) => void;
  change: (selectorOrElement: string | HTMLElement, options?: PromptOptions) => void;
};

export const Prompt: TPrompt = {
  isInited: false,
  init: function () {
    const checkbox = getCheckboxFromPromptContent(this.el || undefined);
    if (checkbox) {
      checkbox.dataset[IS_MOUNTED_DATA] = "true";
    }
    if (!Prompt.isInited) {
      window.addEventListener("keydown", closeFromEscapeKey);
      Prompt.isInited = true;
    }
  },
  mounted: function () {
    this.init();
  },
  updated: function () {
    this.init();
  },
  change: function (selectorOrElement: string | HTMLElement, options: PromptOptions = {}) {
    const checkbox = getCheckboxFromSelectorOrElement(selectorOrElement);
    if (!checkbox || !(checkbox instanceof HTMLInputElement)) {
      return;
    }

    const elements = getElements(checkbox);

    if (checkbox.checked) {
      elements.touchLayer?.addEventListener("click", closeFromTouchLayer);
    } else {
      elements.touchLayer?.removeEventListener("click", closeFromTouchLayer);
    }

    checkbox.addEventListener(
      "transitionend",
      function (evt) {
        setCheckboxState({
          checkbox,
          state: checkbox.checked ? "endShowing" : "endHiding",
          elements,
          options,
          onDidShow: onEndShowing,
        });
      },
      { once: true }
    );

    setCheckboxState({
      checkbox,
      state: checkbox.checked ? "showing" : "hiding",
      elements,
      options,
    });
  },
  hide: function (
    selectorOrElement: string | HTMLElement
  ) {
    if (typeof selectorOrElement !== "string") {
      // Element
      let element = selectorOrElement;
      const root: MaybeHTMLElement = element.closest(ROOT_SELECTOR);
      if (isTouchLayer(element)) {
        // Clicked touch layer
        if (isModal(root)) {
          // Ignore
          return;
        }
      }
    }
    onToggle(selectorOrElement, 'hide')
  },
  show: function (
    selectorOrElement: string | HTMLElement
  ) {
    onToggle(selectorOrElement, 'show');
  },
  toggle: function (
    selectorOrElement: string | HTMLElement
  ) {
    onToggle(selectorOrElement, 'toggle');
  },
};

declare global {
  interface Window {
    Prompt?: typeof Prompt;
  }
}

if (typeof window !== "undefined") {
  window.Prompt = Prompt;
}
