#!/bin/bash

# Create client directory structure script
setup_client() {
  echo "Setting up client directory structure..."
  
  # Create src directories
  mkdir -p client/src/app/auth/login
  mkdir -p client/src/app/auth/register
  mkdir -p client/src/app/dashboard/orders
  mkdir -p client/src/app/dashboard/delivery
  mkdir -p client/src/app/dashboard/cleaning
  mkdir -p client/src/app/api
  mkdir -p client/src/components/{ui,forms,layout}
  mkdir -p client/src/hooks
  mkdir -p client/src/lib
  mkdir -p client/src/services
  mkdir -p client/src/store/slices
  mkdir -p client/src/types
  mkdir -p client/src/utils
  
  # Create base files
  touch client/src/app/layout.tsx
  touch client/src/app/page.tsx
  touch client/src/app/error.tsx
  touch client/src/app/loading.tsx
  touch client/src/app/globals.css
  
  # Auth pages
  touch client/src/app/auth/login/page.tsx
  touch client/src/app/auth/register/page.tsx
  touch client/src/app/auth/layout.tsx
  
  # Dashboard pages
  touch client/src/app/dashboard/page.tsx
  touch client/src/app/dashboard/layout.tsx
  touch client/src/app/dashboard/orders/page.tsx
  touch client/src/app/dashboard/delivery/page.tsx
  touch client/src/app/dashboard/cleaning/page.tsx
  
  # Components
  touch client/src/components/ui/{button,input,card,table}.tsx
  touch client/src/components/forms/{login-form,register-form}.tsx
  touch client/src/components/layout/{header,sidebar,footer}.tsx
  
  # Hooks
  touch client/src/hooks/{use-auth,use-socket,use-toast}.ts
  
  # Lib
  touch client/src/lib/{utils,constants,api-client}.ts
  
  # Services
  touch client/src/services/{auth,api,socket}.ts
  
  # Store
  touch client/src/store/index.ts
  touch client/src/store/slices/{auth-slice,order-slice,ui-slice}.ts
  
  # Types
  touch client/src/types/index.ts
  
  # Utils
  touch client/src/utils/{format,validation}.ts
  
  # Config files
  touch client/.env.local
  touch client/.env.example
  
  echo "Client directory structure created successfully!"
}

# Create server directory structure script
setup_server() {
  echo "Setting up server directory structure..."
  
  # Create server directories
  mkdir -p server/src/{config,controllers,middleware,models,routes,services,sockets,utils,types,validators}
  mkdir -p server/src/db/{migrations,seeds}
  mkdir -p server/tests/{unit,integration}
  
  # Create base files
  touch server/src/index.ts
  touch server/src/app.ts
  
  # Create server package.json with latest versions
  cat > server/package.json << EOF
{
  "name": "restaurant-management-server",
  "version": "1.0.0",
  "private": true,
  "scripts": {
    "dev": "ts-node-dev --respawn --transpile-only src/index.ts",
    "build": "tsc",
    "start": "node dist/index.js",
    "test": "jest",
    "migrate": "knex migrate:latest",
    "seed": "knex seed:run",
    "lint": "eslint . --ext .ts"
  },
  "dependencies": {
    "express": "^4.21.1",
    "bcryptjs": "^2.4.3",
    "cors": "^2.8.5",
    "dotenv": "^16.4.5",
    "knex": "^3.1.0",
    "pg": "^8.11.3",
    "redis": "^7.4.6",
    "socket.io": "^4.8.1",
    "zod": "^3.22.4",
    "jsonwebtoken": "^9.0.2"
  },
  "devDependencies": {
    "@types/express": "^4.17.21",
    "@types/bcryptjs": "^2.4.6",
    "@types/jest": "^29.7.1",
    "@types/jsonwebtoken": "^9.0.5",
    "@types/node": "^20.9.0",
    "@typescript-eslint/eslint-plugin": "^6.11.0",
    "@typescript-eslint/parser": "^6.11.0",
    "eslint": "^8.53.0",
    "jest": "^29.7.1",
    "ts-jest": "^29.1.1",
    "ts-node-dev": "^2.0.0",
    "typescript": "^5.6.3"
  }
}
EOF

  # Create TypeScript configuration
  cat > server/tsconfig.json << EOF
{
  "compilerOptions": {
    "target": "es2017",
    "module": "commonjs",
    "lib": ["es2017", "esnext.asynciterable"],
    "skipLibCheck": true,
    "sourceMap": true,
    "outDir": "./dist",
    "moduleResolution": "node",
    "removeComments": true,
    "noImplicitAny": true,
    "strictNullChecks": true,
    "strictFunctionTypes": true,
    "noImplicitThis": true,
    "noUnusedLocals": true,
    "noUnusedParameters": true,
    "noImplicitReturns": true,
    "noFallthroughCasesInSwitch": true,
    "allowSyntheticDefaultImports": true,
    "esModuleInterop": true,
    "emitDecoratorMetadata": true,
    "experimentalDecorators": true,
    "resolveJsonModule": true,
    "baseUrl": "."
  },
  "exclude": ["node_modules"],
  "include": ["./src/**/*.ts"]
}
EOF

  # Create base configuration files
  touch server/src/config/{database,redis,socket}.ts
  touch server/src/controllers/{auth,order,cleaning,delivery}.ts
  touch server/src/middleware/{auth,error-handler,validation}.ts
  touch server/src/models/{user,order,cleaning-task,delivery}.ts
  touch server/src/routes/{auth,order,cleaning,delivery}.ts
  touch server/src/routes/index.ts
  touch server/src/services/{auth,order,cleaning,delivery,socket}.ts
  touch server/src/sockets/{handlers,events}.ts
  touch server/src/utils/{jwt,password,logger}.ts
  touch server/src/types/index.ts
  touch server/src/validators/{auth,order,cleaning,delivery}.ts
  touch server/src/db/migrations/001_initial.ts
  touch server/src/db/seeds/001_demo_data.ts
  touch server/tests/unit/services.test.ts
  touch server/tests/integration/api.test.ts
  touch server/.env
  touch server/.env.example
  
  echo "Server setup completed successfully!"
}

# Main setup
main() {
  echo "Starting project setup..."
  setup_client
  setup_server
  echo "Project setup completed successfully!"
}

# Execute main function
main