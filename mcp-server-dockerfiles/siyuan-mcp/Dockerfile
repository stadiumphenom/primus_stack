FROM node:18-slim

# Install dependencies
RUN apt-get update && \
    apt-get install -y curl jq git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create app directory
WORKDIR /app

# Create a temporary script to modify package.json
RUN npm init -y && \
    npm install @onigeya/siyuan-mcp-server supergateway

# Copy startup script
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

# Expose the SSE port
EXPOSE 3003

# Set environment variables with defaults
ENV SIYUAN_TOKEN="your-siyuan-token" \
    SIYUAN_SERVER="http://localhost:6806" \
    SSE_PORT=3003 \
    SSE_HOST="0.0.0.0"

# Run the startup script
CMD ["/app/start.sh"]
