#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to create file with content
create_file() {
    local file_path=$1
    local content=$2
    echo -e "$content" > "$file_path"
    echo -e "${BLUE}Created${NC}: $file_path"
}

echo -e "${GREEN}Starting backend setup...${NC}"

# Create base server files
create_file "server/src/index.ts" "import { app } from './app';
import { config } from './config';
import { logger } from './utils/logger';

const start = async () => {
  try {
    const server = app.listen(config.port, () => {
      logger.info(\`Server is running on port \${config.port}\`);
    });

    // Graceful shutdown
    process.on('SIGTERM', () => {
      logger.info('SIGTERM signal received: closing HTTP server');
      server.close(() => {
        logger.info('HTTP server closed');
      });
    });

  } catch (error) {
    logger.error('Error starting server:', error);
    process.exit(1);
  }
};

start();"

create_file "server/src/app.ts" "import express from 'express';
import cors from 'cors';
import { errorHandler } from './middleware/error-handler';
import { routes } from './routes';
import { setupSocket } from './sockets';

const app = express();

// Middleware
app.use(cors());
app.use(express.json());

// Routes
app.use('/api', routes);

// Error handling
app.use(errorHandler);

// Socket.io setup
setupSocket(app);

export { app };"

# Create configuration files
create_file "server/src/config/index.ts" "import dotenv from 'dotenv';
import { z } from 'zod';

dotenv.config();

const envSchema = z.object({
  NODE_ENV: z.enum(['development', 'test', 'production']).default('development'),
  PORT: z.string().default('5000'),
  DATABASE_URL: z.string(),
  REDIS_URL: z.string(),
  JWT_SECRET: z.string(),
  JWT_EXPIRES_IN: z.string().default('7d'),
});

const envVars = envSchema.safeParse(process.env);

if (!envVars.success) {
  throw new Error(\`Environment validation error: \${JSON.stringify(envVars.error.format(), null, 2)}\`);
}

export const config = {
  env: envVars.data.NODE_ENV,
  port: parseInt(envVars.data.PORT, 10),
  databaseUrl: envVars.data.DATABASE_URL,
  redisUrl: envVars.data.REDIS_URL,
  jwt: {
    secret: envVars.data.JWT_SECRET,
    expiresIn: envVars.data.JWT_EXPIRES_IN,
  },
} as const;"

# Create database configuration
create_file "server/src/config/database.ts" "import knex from 'knex';
import { config } from '.';

export const db = knex({
  client: 'pg',
  connection: config.databaseUrl,
  pool: {
    min: 2,
    max: 10
  }
});"

# Create Redis configuration
create_file "server/src/config/redis.ts" "import { createClient } from 'redis';
import { config } from '.';
import { logger } from '../utils/logger';

export const redisClient = createClient({
  url: config.redisUrl
});

redisClient.on('error', (err) => logger.error('Redis Client Error', err));
redisClient.on('connect', () => logger.info('Redis Client Connected'));"

# Create types
create_file "server/src/types/index.ts" "export interface User {
  id: string;
  email: string;
  password: string;
  name: string;
  role: 'admin' | 'manager' | 'cook' | 'delivery' | 'cleaner';
  createdAt: Date;
  updatedAt: Date;
}

export interface Order {
  id: string;
  items: OrderItem[];
  status: OrderStatus;
  totalAmount: number;
  customerId: string;
  assignedTo?: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface OrderItem {
  id: string;
  name: string;
  quantity: number;
  price: number;
  specialInstructions?: string;
}

export type OrderStatus = 
  | 'pending'
  | 'preparing'
  | 'ready'
  | 'delivering'
  | 'delivered'
  | 'cancelled';

export interface CleaningTask {
  id: string;
  title: string;
  description: string;
  status: 'pending' | 'in-progress' | 'completed';
  assignedTo?: string;
  dueDate: Date;
  createdAt: Date;
  updatedAt: Date;
}

export interface ApiError extends Error {
  statusCode: number;
  errors?: Record<string, string[]>;
}"

# Create utility functions
create_file "server/src/utils/logger.ts" "export const logger = {
  info: (message: string, ...args: any[]) => {
    console.log(\`[INFO] \${message}\`, ...args);
  },
  error: (message: string, ...args: any[]) => {
    console.error(\`[ERROR] \${message}\`, ...args);
  },
  warn: (message: string, ...args: any[]) => {
    console.warn(\`[WARN] \${message}\`, ...args);
  },
  debug: (message: string, ...args: any[]) => {
    console.debug(\`[DEBUG] \${message}\`, ...args);
  },
};"

# Create error handler middleware
create_file "server/src/middleware/error-handler.ts" "import { Request, Response, NextFunction } from 'express';
import { ApiError } from '../types';
import { logger } from '../utils/logger';

export const errorHandler = (
  err: ApiError,
  req: Request,
  res: Response,
  next: NextFunction
) => {
  logger.error(err.message);

  const statusCode = err.statusCode || 500;
  const message = err.message || 'Internal Server Error';
  const errors = err.errors || undefined;

  res.status(statusCode).json({
    success: false,
    message,
    errors,
    stack: process.env.NODE_ENV === 'development' ? err.stack : undefined,
  });
};"

# Create authentication middleware
create_file "server/src/middleware/auth.ts" "import { Request, Response, NextFunction } from 'express';
import jwt from 'jsonwebtoken';
import { config } from '../config';
import { User } from '../types';

declare global {
  namespace Express {
    interface Request {
      user?: User;
    }
  }
}

export const auth = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const token = req.header('Authorization')?.replace('Bearer ', '');

    if (!token) {
      throw new Error('Authentication required');
    }

    const decoded = jwt.verify(token, config.jwt.secret) as any;
    // TODO: Get user from database
    // const user = await getUserById(decoded.id);

    // req.user = user;
    next();
  } catch (error) {
    res.status(401).json({ message: 'Please authenticate' });
  }
};"

# Create initial database migration
create_file "server/src/db/migrations/001_initial.ts" "import { Knex } from 'knex';

export async function up(knex: Knex): Promise<void> {
  // Users table
  await knex.schema.createTable('users', (table) => {
    table.uuid('id').primary().defaultTo(knex.raw('gen_random_uuid()'));
    table.string('email').unique().notNullable();
    table.string('password').notNullable();
    table.string('name').notNullable();
    table.enum('role', ['admin', 'manager', 'cook', 'delivery', 'cleaner']).notNullable();
    table.timestamps(true, true);
  });

  // Orders table
  await knex.schema.createTable('orders', (table) => {
    table.uuid('id').primary().defaultTo(knex.raw('gen_random_uuid()'));
    table.jsonb('items').notNullable();
    table.enum('status', [
      'pending',
      'preparing',
      'ready',
      'delivering',
      'delivered',
      'cancelled'
    ]).notNullable();
    table.decimal('total_amount', 10, 2).notNullable();
    table.string('customer_id').notNullable();
    table.uuid('assigned_to').references('id').inTable('users');
    table.timestamps(true, true);
  });

  // Cleaning tasks table
  await knex.schema.createTable('cleaning_tasks', (table) => {
    table.uuid('id').primary().defaultTo(knex.raw('gen_random_uuid()'));
    table.string('title').notNullable();
    table.text('description');
    table.enum('status', ['pending', 'in-progress', 'completed']).notNullable();
    table.uuid('assigned_to').references('id').inTable('users');
    table.timestamp('due_date').notNullable();
    table.timestamps(true, true);
  });
}

export async function down(knex: Knex): Promise<void> {
  await knex.schema.dropTable('cleaning_tasks');
  await knex.schema.dropTable('orders');
  await knex.schema.dropTable('users');
}"

# Create example environment file
create_file "server/.env.example" "NODE_ENV=development
PORT=5000
DATABASE_URL=postgresql://postgres:postgres@localhost:5432/restaurant_db
REDIS_URL=redis://localhost:6379
JWT_SECRET=your-super-secret-jwt-key
JWT_EXPIRES_IN=7d"

# Create initial test file
create_file "server/tests/unit/services.test.ts" "import { describe, expect, test } from '@jest/globals';

describe('Service Tests', () => {
  test('should pass', () => {
    expect(true).toBe(true);
  });
});"

# Create knexfile for database migrations
create_file "server/knexfile.ts" "import { config } from './src/config';
import type { Knex } from 'knex';

const knexConfig: { [key: string]: Knex.Config } = {
  development: {
    client: 'pg',
    connection: config.databaseUrl,
    pool: {
      min: 2,
      max: 10
    },
    migrations: {
      tableName: 'knex_migrations',
      directory: './src/db/migrations'
    },
    seeds: {
      directory: './src/db/seeds'
    }
  },
  test: {
    client: 'pg',
    connection: config.databaseUrl,
    migrations: {
      tableName: 'knex_migrations',
      directory: './src/db/migrations'
    },
    seeds: {
      directory: './src/db/seeds'
    }
  },
  production: {
    client: 'pg',
    connection: config.databaseUrl,
    pool: {
      min: 2,
      max: 10
    },
    migrations: {
      tableName: 'knex_migrations',
      directory: './src/db/migrations'
    }
  }
};

export default knexConfig;"

echo -e "${GREEN}Backend setup completed!${NC}"

echo -e "${BLUE}Next steps:${NC}"
echo "1. cd server"
echo "2. npm install"
echo "3. Copy .env.example to .env and update the values"
echo "4. Run migrations: npm run migrate"
echo "5. Start the server: npm run dev"
