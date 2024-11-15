import { createClient } from 'redis';
import { config } from '.';
import { logger } from '../utils/logger';

export const redisClient = createClient({
  url: config.redisUrl
});

redisClient.on('error', (err) => logger.error('Redis Client Error', err));
redisClient.on('connect', () => logger.info('Redis Client Connected'));
