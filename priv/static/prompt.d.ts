/**
Prompt Hook handles status callbacks.
*/
export type TPrompt = {
    el?: HTMLElement;
    mounted: () => void;
    destroyed: () => void;
    pushEventTo?: (selector: string, eventName: string, payload?: Object, onReply?: () => void) => void;
    handlePromptOpen?: (evt: CustomEvent) => void;
    handlePromptClose?: (evt: CustomEvent) => void;
};
export declare const Prompt: TPrompt;
declare global {
    interface Window {
        Prompt?: typeof Prompt;
    }
}
