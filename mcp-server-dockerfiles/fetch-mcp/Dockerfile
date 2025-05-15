FROM node:20-slim

# Install git for cloning the repository
RUN apt-get update && apt-get install -y git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create app directory
WORKDIR /app

# Clone the repository
RUN git clone https://github.com/zcaceres/fetch-mcp .

# Install dependencies and build the server
RUN npm install && \
    npm run build && \
    npm install -g supergateway

# Create a non-root user
RUN groupadd -r mcpuser && \
    useradd -r -g mcpuser -d /app mcpuser && \
    chown -R mcpuser:mcpuser /app

USER mcpuser

# Copy the startup script
COPY --chown=mcpuser:mcpuser start.sh /app/start.sh
RUN chmod +x /app/start.sh

# Expose the SSE port
EXPOSE 3020

# Start the server
CMD ["/app/start.sh"]
