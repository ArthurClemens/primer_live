import { Session } from '../js/session';

describe('Session', () => {
  test('mounted callback should exist', () => {
    expect(!!Session.mounted).toBe(true);
  });
});
