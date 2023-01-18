export type TSession = {
    /**
     * Phoenix LiveView callback.
     */
    mounted: () => void;
};
export declare const Session: {
    mounted(): void;
};
declare global {
    interface Window {
        Session?: TSession;
    }
}
