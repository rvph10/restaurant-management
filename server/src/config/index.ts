import dotenv from 'dotenv';
import { z } from 'zod';

dotenv.config();

const envSchema = z.object({
  NODE_ENV: z.enum(['development', 'test', 'production']).default('development'),
  PORT: z.string().default('5000'),
  DATABASE_URL: z.string(),
  REDIS_URL: z.string(),
  JWT_SECRET: z.string(),
  JWT_EXPIRES_IN: z.string().default('7d'),
  // Add any other environment variables you need
});

const envVars = envSchema.safeParse(process.env);

if (!envVars.success) {
  throw new Error(`Environment validation error: ${JSON.stringify(envVars.error.format(), null, 2)}`);
}

export const config = {
  env: envVars.data.NODE_ENV,
  port: parseInt(envVars.data.PORT, 10),
  database: {
    url: envVars.data.DATABASE_URL,
    // Add any additional database config here
  },
  redis: {
    url: envVars.data.REDIS_URL,
  },
  jwt: {
    secret: envVars.data.JWT_SECRET,
    expiresIn: envVars.data.JWT_EXPIRES_IN,
  },
} as const;