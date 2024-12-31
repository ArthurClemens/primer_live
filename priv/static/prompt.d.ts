import { ViewHook, LiveSocket } from "phoenix_live_view";
/**
Prompt Hook handles status callbacks.
*/
interface IPrompt extends ViewHook<TPrompt> {
    handlePromptOpen?: (evt: CustomEvent) => void;
    handlePromptClose?: (evt: CustomEvent) => void;
    handlePromptToggle?: (evt: CustomEvent) => void;
}
export type TPrompt = IPrompt & {
    liveSocket?: LiveSocket;
};
export declare const Prompt: TPrompt;
declare global {
    interface Window {
        Prompt: TPrompt;
    }
}
export {};
