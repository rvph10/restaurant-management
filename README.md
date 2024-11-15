# Restaurant Management System 
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![TypeScript](https://img.shields.io/badge/TypeScript-5.0-blue.svg)](https://www.typescriptlang.org/)
[![Next.js](https://img.shields.io/badge/Next.js-15.0.3-black.svg)](https://nextjs.org/)
[![Express.js](https://img.shields.io/badge/Express.js-4.21.1-lightgrey.svg)](https://expressjs.com/)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-15-336791.svg)](https://www.postgresql.org/)
[![Redis](https://img.shields.io/badge/Redis-7-red.svg)](https://redis.io/)
[![Docker](https://img.shields.io/badge/Docker-🐳-blue.svg)](https://www.docker.com/)
[![code style: prettier](https://img.shields.io/badge/code_style-prettier-ff69b4.svg)](https://github.com/prettier/prettier)
[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-yellow.svg)](https://conventionalcommits.org)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](http://makeapullrequest.com)

## Project Overview
A full-stack restaurant management system built with Next.js, Express, and PostgreSQL, designed to handle order processing, delivery tracking, staff management, and cleaning tasks.

## Technology Stack
### Frontend
- Next.js 15.0.3 (React 19)
- TailwindCSS for styling
- Redux Toolkit for state management
- React Query for data fetching
- Socket.IO for real-time updates

### Backend
- Node.js with Express
- TypeScript
- PostgreSQL with Knex.js
- Redis for caching
- Socket.IO for real-time communication

### Infrastructure
- Docker and Docker Compose
- WSL (Windows Subsystem for Linux)
- Ubuntu development environment

## Project Structure
```
├── client/                  # Next.js frontend application
│   ├── src/
│   │   ├── app/            # Next.js 13+ app directory
│   │   ├── components/     # Reusable React components
│   │   ├── hooks/         # Custom React hooks
│   │   ├── services/      # API service layers
│   │   └── store/         # Redux store configuration
├── server/                 # Express backend application
│   ├── src/
│   │   ├── controllers/   # Route controllers
│   │   ├── services/      # Business logic
│   │   ├── models/        # Database models
│   │   └── middleware/    # Express middleware
└── docker/                # Docker configuration files
```

## Setup Instructions
1. Clone the repository:
   ```bash
   git clone https://github.com/rvph10/restaurant-management.git
   ```

2. Install dependencies:
   ```bash
   npm run setup
   ```

3. Configure environment variables:
   - Copy `.env.example` to `.env` in both client and server directories
   - Update variables as needed

4. Start development environment:
   ```bash
   docker-compose up
   ```

## Development Workflow

### Branch Strategy
- `main`: Production-ready code
- `develop`: Integration branch
- `feature/*`: New features
- `bugfix/*`: Bug fixes
- `hotfix/*`: Production hotfixes

### Commit Convention
```
type(scope): description

- feat: New feature
- fix: Bug fix
- docs: Documentation
- style: Formatting
- refactor: Code restructuring
- test: Adding tests
- chore: Maintenance
```

### Database Migrations
Run migrations:
```bash
cd server
npm run migrate
```

Create new migration:
```bash
npx knex migrate:make migration_name
```

## API Documentation

### Authentication
```typescript
POST /api/auth/login
POST /api/auth/register
POST /api/auth/refresh-token
```

### Orders
```typescript
GET /api/orders
POST /api/orders
GET /api/orders/:id
PATCH /api/orders/:id
```

### Delivery
```typescript
GET /api/delivery
POST /api/delivery/assign
PATCH /api/delivery/:id/status
```

### Cleaning
```typescript
GET /api/cleaning/tasks
POST /api/cleaning/tasks
PATCH /api/cleaning/tasks/:id
```

## Testing
```bash
# Run backend tests
cd server
npm run test

# Run frontend tests
cd client
npm run test
```

## Deployment
The application is containerized and can be deployed using Docker Compose:

```bash
# Production build
docker-compose -f docker-compose.prod.yml up -d
```

## Monitoring & Logging
- Application logs are handled by the custom logger utility
- Server logs are available through Docker logs
- PostgreSQL logs are stored in the postgres_data volume

## Security Considerations
- JWT authentication with refresh tokens
- Role-based access control (RBAC)
- Rate limiting on API endpoints
- SQL injection prevention through Knex.js
- XSS protection through React's built-in escaping
- CORS configuration for API access

## Contributing
1. Fork the repository
2. Create a feature branch
3. Commit changes
4. Push to the branch
5. Create a Pull Request

## License
This project is licensed under the MIT License - see the LICENSE file for details.