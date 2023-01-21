import { Prompt } from 'dialogic-js';

describe('Prompt', () => {
  test('mounted callback should exist', () => {
    expect(!!Prompt.mounted).toBe(true);
  });
});
