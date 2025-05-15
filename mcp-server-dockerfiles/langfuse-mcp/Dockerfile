FROM node:20-slim

# Install git and required dependencies
RUN apt-get update && apt-get install -y \
    git \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Clone the repository
RUN git clone https://github.com/langfuse/mcp-server-langfuse.git .

# Install dependencies
RUN npm install

# Install supergateway globally
RUN npm install -g supergateway

# Build the MCP server
RUN npm run build

# Create a non-root user to run the application
RUN groupadd -r mcpuser && useradd -r -g mcpuser mcpuser
RUN chown -R mcpuser:mcpuser /app

# Copy the startup script
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

# Switch to non-root user
USER mcpuser

# Start the server with supergateway via the startup script
CMD ["/app/start.sh"]
