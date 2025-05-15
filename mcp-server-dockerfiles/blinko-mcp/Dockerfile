FROM node:18-slim

WORKDIR /app

# Install supergateway globally
RUN npm install -g supergateway

# Create a directory for scripts
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

# Create a directory for logs
RUN mkdir -p /app/logs

# Set the entrypoint
ENTRYPOINT ["/app/start.sh"]
