import { Hook } from "phoenix_live_view";
/**
Prompt Hook handles status callbacks.
*/
interface IPrompt {
    handlePromptOpen?: (evt: CustomEvent) => void;
    handlePromptClose?: (evt: CustomEvent) => void;
    handlePromptToggle?: (evt: CustomEvent) => void;
}
export declare const Prompt: Hook<IPrompt>;
declare global {
    interface Window {
        Prompt: Hook<IPrompt>;
    }
}
export {};
