# Build stage
FROM node:22-alpine AS builder

WORKDIR /app

COPY package*.json ./
RUN npm ci

COPY . .
RUN npm run build

# Production stage
FROM node:22-alpine

WORKDIR /app

RUN npm i -g serve

COPY --from=builder /app/dist ./dist

EXPOSE 5175

CMD ["serve", "-s", "dist", "-l", "5175"]