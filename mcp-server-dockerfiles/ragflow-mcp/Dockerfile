FROM python:3.12-slim

# Install Node.js for supergateway
RUN apt-get update && apt-get install -y \
    nodejs \
    npm \
    git \
    && rm -rf /var/lib/apt/lists/*

# Install supergateway for STDIO to SSE conversion
RUN npm install -g supergateway

# Set the working directory
WORKDIR /app

# Clone the repository
RUN git clone https://github.com/xiangmy21/ragflow_mcp_server.git /app

# Install Python dependencies
RUN pip install --no-cache-dir "mcp[cli]>=1.6.0" httpx

# Copy the start script (not present in original repo)
COPY start.sh /app/

# Set executable permissions for the startup script
RUN chmod +x /app/start.sh

# Create logs directory
RUN mkdir -p /app/logs

# Run the startup script
CMD ["/app/start.sh"]
