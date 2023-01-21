import type { Config } from '@jest/types';

export default async (): Promise<Config.InitialOptions> => ({
  preset: 'ts-jest',
  testEnvironment: 'node',
  globals: {
    window: {},
  },
});
