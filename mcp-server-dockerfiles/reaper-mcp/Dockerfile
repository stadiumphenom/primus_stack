FROM python:3.12-slim

# Set environment variables
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PIP_NO_CACHE_DIR=1

# Install Node.js for supergateway and Git for cloning the repository
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    curl \
    gnupg \
    git \
    procps \
    && curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y --no-install-recommends nodejs \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && npm install -g supergateway

# Create app directory
WORKDIR /app

# Clone the repository
RUN git clone https://github.com/hamzabels85/reaper-mcp.git /app/reaper-mcp

# Install Python dependencies
RUN pip install --no-cache-dir \
    python-osc \
    mcp-server \
    numpy \
    fastapi \
    uvicorn

# Copy startup script
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

# Command to run the server
CMD ["/app/start.sh"]
