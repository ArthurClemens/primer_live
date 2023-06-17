type PhxEvent = Record<string, unknown>;

export type TTheme = {
  /**
   * Phoenix LiveView callback.
   */
  mounted: () => void;
};

export const Theme: TTheme = {
  mounted() {
    window.addEventListener('phx:pl-session', (e: CustomEvent<PhxEvent>) =>
      fetch(`/api/pl-session?payload=${JSON.stringify(e.detail)}`, {
        method: 'post',
      })
    );
  },
};

declare global {
  interface Window {
    Theme?: TTheme;
  }
}

window.Theme = Theme;
