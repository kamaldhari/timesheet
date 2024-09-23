# Step 1: Build the application
FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm i 

COPY . .
RUN npm run build

# Step 2: Set up the production environment
FROM nginx:1.26-alpine-slim
COPY --from=builder /app/dist /usr/share/nginx/html
COPY Docker/nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]