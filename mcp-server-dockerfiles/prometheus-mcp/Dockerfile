FROM python:3.12-slim AS mcp-server

# Install required tools and dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    curl \
    gnupg \
    ca-certificates \
    git \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js for supergateway
RUN mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get update && \
    apt-get install -y --no-install-recommends nodejs && \
    rm -rf /var/lib/apt/lists/*

# Install supergateway globally
RUN npm install -g supergateway

# Create app directory
WORKDIR /app

# Clone the Prometheus MCP server
RUN git clone https://github.com/pab1it0/prometheus-mcp-server.git /app

# Install the package directly using pip instead of uv
RUN pip install -e .

# Copy startup script
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

# Expose the SSE port
EXPOSE 3014

# Set environment variables
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONPATH="/app" \
    PYTHONFAULTHANDLER=1

# Run the start script
CMD ["/app/start.sh"]
