FROM node:20-slim

# Install Chrome dependencies
RUN apt-get update && apt-get install -y \
    wget \
    gnupg \
    ca-certificates \
    fonts-liberation \
    libasound2 \
    libatk-bridge2.0-0 \
    libatk1.0-0 \
    libatspi2.0-0 \
    libcups2 \
    libdbus-1-3 \
    libdrm2 \
    libgbm1 \
    libgtk-3-0 \
    libnspr4 \
    libnss3 \
    libwayland-client0 \
    libxcomposite1 \
    libxdamage1 \
    libxfixes3 \
    libxkbcommon0 \
    libxrandr2 \
    xdg-utils \
    git \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Puppeteer MCP server
RUN npm install -g @modelcontextprotocol/server-puppeteer

# Install supergateway for STDIO to SSE conversion
RUN npm install -g supergateway

# Set working directory
WORKDIR /app

# Copy our start script
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

# Set entrypoint
ENTRYPOINT ["/app/start.sh"]
