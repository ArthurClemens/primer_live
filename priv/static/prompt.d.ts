import { ViewHook, LiveSocket } from "phoenix_live_view";
/**
Prompt Hook handles status callbacks.
*/
export type TPrompt = Partial<ViewHook> & {
    handlePromptOpen?: (evt: CustomEvent) => void;
    handlePromptClose?: (evt: CustomEvent) => void;
    handlePromptToggle?: (evt: CustomEvent) => void;
    liveSocket?: LiveSocket;
};
export declare const Prompt: TPrompt;
declare global {
    interface Window {
        Prompt: TPrompt;
    }
}
