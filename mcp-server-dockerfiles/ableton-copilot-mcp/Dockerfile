FROM node:20-slim

# Install necessary tools
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    curl \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Install supergateway globally
RUN npm install -g supergateway

# Create directory for persistent data
RUN mkdir -p /data

# Copy start script
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

# Set environment variables
ENV NODE_ENV=production \
    BASE_PATH=/data

# Expose the port
EXPOSE ${SSE_PORT}

# Start the application using the start script
CMD ["/app/start.sh"]
