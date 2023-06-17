export type TTheme = {
    /**
     * Phoenix LiveView callback.
     */
    mounted: () => void;
};
export declare const Theme: TTheme;
declare global {
    interface Window {
        Theme?: TTheme;
    }
}
