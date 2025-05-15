FROM node:20-slim

# Set working directory
WORKDIR /app

# Install git for cloning the repository
RUN apt-get update && apt-get install -y git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Clone the TriliumNext MCP repository
RUN git clone https://github.com/tan-yong-sheng/triliumnext-mcp.git /app

# Install dependencies and build the application
RUN npm install && \
    npm run build

# Install supergateway globally
RUN npm install -g supergateway

# Copy the startup script
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

# Set the startup command
CMD ["/app/start.sh"]
