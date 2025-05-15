FROM node:18-slim
# Install dependencies
RUN apt-get update && \
    apt-get install -y curl jq git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
# Create app directory
WORKDIR /app
# Install the Karakeep MCP package and supergateway
RUN npm install -g @karakeep/mcp supergateway
# Verify installation
RUN npm list -g --depth=0 | grep @karakeep/mcp || echo "Warning: @karakeep/mcp not found in global modules"
RUN npm list -g --depth=0 | grep supergateway || echo "Warning: supergateway not found in global modules"
# Copy startup script
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh
# Expose the SSE port
EXPOSE <YOUR_SSE_PORT>
# Set environment variables with defaults
ENV KARAKEEP_API_ADDR="<YOUR_KARAKEEP_API_URL>" \
    KARAKEEP_API_KEY="<YOUR_KARAKEEP_API_KEY>" \
    SSE_PORT=<YOUR_SSE_PORT> \
    SSE_HOST="0.0.0.0"
# Run the startup script
CMD ["/app/start.sh"]