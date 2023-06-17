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
export declare const Prompt: TPrompt;
declare global {
    interface Window {
        Prompt?: typeof Prompt;
    }
}
export {};
