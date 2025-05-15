FROM python:3.10-slim

# Install git and other dependencies
RUN apt-get update && apt-get install -y git curl plocate && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Install Node.js and npm
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install the MCP Everything Search server using pip
RUN pip install mcp-server-everything-search

# Install supergateway for STDIO to SSE conversion
RUN npm install -g supergateway

# Copy our start script
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

# Set entrypoint
ENTRYPOINT ["/app/start.sh"]
