FROM python:3.13-slim
# Install git for cloning the repository and Node.js for supergateway
RUN apt-get update && apt-get install -y git nodejs npm && apt-get clean && rm -rf /var/lib/apt/lists/*
# Set working directory
WORKDIR /app
# Clone the MCP server repository
RUN git clone https://github.com/LeslieLeung/mcp-server-memos.git .
# Install Python dependencies
RUN pip install --no-cache-dir setuptools wheel
RUN pip install --no-cache-dir .
# Install supergateway for STDIO to SSE conversion
RUN npm install -g supergateway
# Create a directory for logs
RUN mkdir -p /app/logs
# Copy startup script
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh
# Set environment variables (will be overridden by docker-compose)
ENV MEMOS_URL=<YOUR_MEMOS_URL>
ENV MEMOS_API_KEY=<YOUR_MEMOS_API_KEY>
ENV DEFAULT_TAG=#mcp
ENV SSE_PORT=<YOUR_SSE_PORT>
ENV HOST_IP=<YOUR_HOST_IP>
# Expose the port for the SSE endpoint
EXPOSE ${SSE_PORT}
# Run the startup script
CMD ["/app/start.sh"]