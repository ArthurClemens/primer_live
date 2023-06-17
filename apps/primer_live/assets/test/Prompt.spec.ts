import { Prompt } from '../js/prompt';

describe('Prompt', () => {
  test('mounted callback should exist', () => {
    expect(!!Prompt.mounted).toBe(true);
  });
});
