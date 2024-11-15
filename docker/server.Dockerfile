FROM node:18-alpine

WORKDIR /app

# Add postgresql-client for database migrations
RUN apk add --no-cache postgresql-client

# Install dependencies first for better caching
COPY package*.json ./
RUN npm install --legacy-peer-deps

# Copy source code
COPY . .

EXPOSE 5000

# Start the server
CMD ["npm", "run", "dev"]