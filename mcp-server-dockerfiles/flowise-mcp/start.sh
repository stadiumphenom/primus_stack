#!/bin/bash
set -e

# Log configuration for debugging
echo "============================================"
echo "MCP-Flowise Server Configuration"
echo "============================================"
echo "Host IP: $HOST_IP"
echo "SSE Port: $SSE_PORT"
echo "Flowise API Endpoint: $FLOWISE_API_ENDPOINT"
echo "Flowise API Key: ${FLOWISE_API_KEY:0:3}...redacted"
echo "============================================"

# Clone the repository if not already present
if [ ! -d "/app/mcp-flowise" ]; then
  echo "Cloning mcp-flowise repository..."
  git clone https://github.com/matthewhand/mcp-flowise.git /app/mcp-flowise
fi

# Start the supergateway with the MCP server
echo "Starting supergateway with MCP-Flowise server..."
cd /app/mcp-flowise

# Install the package if needed
if [ ! -f "/app/mcp-flowise/.installed" ]; then
  echo "Installing mcp-flowise package..."
  pip install -e .
  touch /app/mcp-flowise/.installed
fi

# Start supergateway with the correct command to run mcp-flowise
exec supergateway --stdio "python -m mcp_flowise" --port $SSE_PORT
