FROM node:18-alpine

WORKDIR /app

# Install dependencies first for better caching
COPY package*.json ./
RUN npm install --legacy-peer-deps

# Copy source code
COPY . .

EXPOSE 3000

CMD ["npm", "run", "dev"]