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
type TPrompt = {
    el?: MaybeHTMLElement;
    checkbox?: MaybeHTMLElement;
    init: () => void;
    mounted: () => void;
    updated: () => void;
    change: (checkbox: HTMLInputElement, options: PromptOptions) => void;
    hide: (selectorOrElement: string | HTMLElement) => void;
    show: (selectorOrElement: string | HTMLElement) => void;
};
export declare const Prompt: TPrompt;
declare global {
    interface Window {
        Prompt?: typeof Prompt;
    }
}
export {};
