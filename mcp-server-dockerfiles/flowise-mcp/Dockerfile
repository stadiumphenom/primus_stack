# Use a Python base image
FROM python:3.12-slim

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js for supergateway
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

# Install supergateway globally
RUN npm install -g supergateway

# Install Python dependencies (we'll install uvx in the container but not use the uvx command directly)
RUN pip install --no-cache-dir uvx

# Create directory for the app
RUN mkdir -p /app

# Copy startup script
COPY start.sh /app/
RUN chmod +x /app/start.sh

# Expose the port for SSE
EXPOSE 3011

# Set environment variables (these will be overridden by docker-compose)
ENV FLOWISE_API_KEY="your_api_key_here" \
    FLOWISE_API_ENDPOINT="http://localhost:3000" \
    HOST_IP="192.168.50.196" \
    SSE_PORT="3011"

# Use the startup script as entrypoint
ENTRYPOINT ["/app/start.sh"]
