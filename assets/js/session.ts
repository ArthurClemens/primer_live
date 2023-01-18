type PhxEvent = Record<string, unknown>;

export type TSession = {
  /**
   * Phoenix LiveView callback.
   */
  mounted: () => void;
};

export const Session = {
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
    Session?: TSession;
  }
}

window.Session = Session;
