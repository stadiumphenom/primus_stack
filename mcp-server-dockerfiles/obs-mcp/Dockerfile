FROM node:20-slim

# Install git for cloning the repository
RUN apt-get update && apt-get install -y git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Clone the repository
RUN git clone https://github.com/royshil/obs-mcp.git /app

# Install dependencies and build
RUN npm install && \
    npm run build && \
    npm install -g supergateway

# Copy the start script
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

# Expose the SSE port
EXPOSE ${SSE_PORT:-3012}

# Set entrypoint
ENTRYPOINT ["/app/start.sh"]
