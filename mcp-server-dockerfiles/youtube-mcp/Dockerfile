FROM python:3.12-slim

# Set working directory
WORKDIR /app

# Install system dependencies and supergateway
RUN apt-get update && \
    apt-get install -y curl git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g supergateway

# Clone the repository
RUN git clone https://github.com/adhikasp/mcp-youtube.git /app/mcp-youtube
WORKDIR /app/mcp-youtube

# Install Python dependencies and the package itself
RUN pip install --no-cache-dir -e .

# Set environment variables
ENV HOST_IP="0.0.0.0"
ENV SSE_PORT="3021"

# Copy start script
COPY ./start.sh /app/start.sh
RUN chmod +x /app/start.sh

# Set the entrypoint
ENTRYPOINT ["/app/start.sh"]
