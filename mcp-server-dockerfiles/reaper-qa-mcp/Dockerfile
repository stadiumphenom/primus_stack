FROM python:3.12-slim

# Set up environment variables
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PIP_NO_CACHE_DIR=1

# Install Node.js for supergateway
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    git \
    curl \
    gnupg && \
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y --no-install-recommends nodejs && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install supergateway globally
RUN npm install -g supergateway

# Create app directory
WORKDIR /app

# Clone the repository
RUN git clone https://github.com/dschuler36/reaper-mcp-server.git .

# Install Python dependencies
RUN pip install .

# Copy start script and make it executable
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

# Set the entrypoint
ENTRYPOINT ["/app/start.sh"]
