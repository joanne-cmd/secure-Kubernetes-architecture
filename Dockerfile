# Use specific version for base image
FROM node:18-alpine3.18

# Create non-root user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Set working directory
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm ci --only=production

# Copy application code
COPY --chown=appuser:appgroup . .

# Use non-root user
USER appuser

# Set security configurations
ENV NODE_ENV=production

# Expose port
EXPOSE 3000

# Start application
CMD ["npm", "start"]
