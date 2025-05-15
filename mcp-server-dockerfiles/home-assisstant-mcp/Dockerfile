FROM ghcr.io/astral-sh/uv:0.6.6-python3.13-bookworm

# Install Node.js for supergateway
RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    && curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install supergateway globally
RUN npm install -g supergateway

# Set working directory
WORKDIR /app

# Clone the repository
RUN apt-get update && apt-get install -y git && \
    git clone https://github.com/voska/hass-mcp.git . && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set environment for MCP communication
ENV PYTHONUNBUFFERED=1
ENV PYTHONPATH=/app

# Install package with UV (using --system flag)
RUN uv pip install --system -e .

# Copy startup script
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Set entrypoint to the startup script
ENTRYPOINT ["/start.sh"]
