type MaybeHTMLElement = HTMLElement | null;

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

type PromptState = 'showing' | 'endShowing' | 'hiding' | 'endHiding';

function getCheckboxFromPromptContent(contentElement: HTMLElement) {
  const root = contentElement.closest('[data-prompt]');
  if (!root) {
    return null; 
  }
  const checkbox: HTMLInputElement | null = root.querySelector('input[type="checkbox"]');
  if (!checkbox) {
    return null;
  }
  return checkbox;
}

function getCheckboxFromSelectorOrElement(selectorOrElement: string | HTMLElement) {
  let checkbox: HTMLInputElement | null = null;
  if (typeof selectorOrElement === "string") {
    const element: MaybeHTMLElement = document.querySelector(selectorOrElement);
    if (element) {
      checkbox = element.querySelector('input[type="checkbox"]');
    }
  } else {
    checkbox = getCheckboxFromPromptContent(selectorOrElement);
  }
  return checkbox;
}
    
function getElements(checkbox: HTMLInputElement): PromptElements {
  const root: MaybeHTMLElement = checkbox.closest('[data-prompt]');

  if (!root) {
    throw new Error("Prompt element 'data-prompt' not found")
  }

  const wrapper: MaybeHTMLElement = root?.querySelector('[data-prompt-content]') || null;
  if (!wrapper) {
    throw new Error("Prompt element 'data-prompt-content' not found")
  }

  const content: MaybeHTMLElement = wrapper?.querySelector('[data-content]');
  if (!content) {
    throw new Error("Prompt element 'data-content' not found")
  }

  const touchLayer: MaybeHTMLElement = wrapper?.querySelector('[data-touch]') || null;
  const toggle: MaybeHTMLElement = root?.querySelector('label') || null;
  
  return {
    root,
    touchLayer,
    content,
    toggle
  }
}

function setCheckboxState({
  checkbox,
  state,
  elements,
  options,
} : {
  checkbox: HTMLInputElement;
  state: PromptState;
  elements: PromptElements;
  options: PromptOptions;
}) {
  switch (state) {
    case 'showing':
      delete checkbox.dataset.ishiding;
      checkbox.dataset.isshowing = "";
      if (options.willShow) {
        options.willShow(elements)
      }
      break;
    case 'endShowing':
      delete checkbox.dataset.isshowing;
      if (options.didShow) {
        options.didShow(elements)
      }
      break;
    case 'hiding':
      delete checkbox.dataset.isshowing;
      checkbox.checked = false;
      checkbox.dataset.ishiding = "";
      if (options.willHide) {
        options.willHide(elements)
      }
      break;
    case 'endHiding':
      delete checkbox.dataset.ishiding;
      if (options.didHide) {
        options.didHide(elements)
      }
      break;
    default:
      break;
  }
}

export const Prompt = {
  mounted() {},
  change: function(checkbox: HTMLInputElement, options: PromptOptions = {}) {
    const elements = getElements(checkbox);
    checkbox.addEventListener('transitionend', function(evt) {
      setCheckboxState({ checkbox, state: checkbox.checked ? 'endShowing' : 'endHiding', elements, options });
    }, { once: true });
    setCheckboxState({ checkbox, state: checkbox.checked ? 'showing' : 'hiding', elements, options });
  },
  hide: function(selectorOrElement: string | HTMLElement) {
    if (typeof selectorOrElement !== 'string' && selectorOrElement.dataset.touch !== undefined) {
      // Clicked touch layer
      const root: MaybeHTMLElement = selectorOrElement.closest('[data-prompt]');
      if (root?.dataset.ismodal !== undefined) {
        return;
      }
    }
    getCheckboxFromSelectorOrElement(selectorOrElement)?.click();
  },
  show: function(selectorOrElement: string | HTMLElement) {
    getCheckboxFromSelectorOrElement(selectorOrElement)?.click();
  },
}

declare global {
  interface Window {
    Prompt?: typeof Prompt;
  }
}

if (typeof window !== 'undefined') {
  window.Prompt = Prompt;
}
