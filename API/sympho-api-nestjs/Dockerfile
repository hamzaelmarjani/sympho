##############################
# Stage 1: Build the app
##############################
FROM node:18-alpine AS builder

# Set working directory
WORKDIR /usr/src/app

# Copy package files and install deps (including devDependencies)
COPY package*.json ./
RUN npm install

# Copy the rest of the source code
COPY . .

# Build the NestJS app -> outputs to /dist
RUN npm run build


##############################
# Stage 2: Run the app
##############################
FROM node:18-alpine

# Set environment variable to production
ENV NODE_ENV=production

# Set working directory inside container
WORKDIR /usr/src/app

# Copy only package files and install *production* dependencies
COPY package*.json ./
RUN npm install --omit=dev

# Copy build output from the builder stage
COPY --from=builder /usr/src/app/dist ./dist

# Define the command to run the app
CMD ["node", "dist/main.js"]

# Expose port 8080 for external access
EXPOSE 8080