import { Theme } from '../js/theme';

describe('Theme', () => {
  test('mounted callback should exist', () => {
    expect(!!Theme.mounted).toBe(true);
  });
});
