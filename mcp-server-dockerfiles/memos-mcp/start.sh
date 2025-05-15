#!/bin/sh

# Log the configuration for debugging
echo "Starting MCP server with the following configuration:"
echo "MEMOS_URL: $MEMOS_URL"
echo "DEFAULT_TAG: $DEFAULT_TAG"
echo "SSE_PORT: $SSE_PORT"
echo "HOST_IP: $HOST_IP"
echo "MCP API Key is configured but not displayed for security"

# Log the Python version and Node.js version
echo "Python version: $(python --version)"
echo "Node.js version: $(node -v)"
echo "NPM version: $(npm -v)"

# Check if the required environment variables are set
if [ -z "$MEMOS_URL" ] || [ -z "$MEMOS_API_KEY" ]; then
  echo "Error: MEMOS_URL and MEMOS_API_KEY environment variables must be set."
  exit 1
fi

# Create log directory if it doesn't exist
mkdir -p /app/logs

# Set the environment variables for the Python script
export MEMOS_URL
export MEMOS_API_KEY
export DEFAULT_TAG

# Start supergateway with the MCP server as STDIO input
# This converts STDIO to SSE for n8n
echo "Starting supergateway to bridge STDIO to SSE on port $SSE_PORT..."
supergateway --stdio "python main.py" --port $SSE_PORT > /app/logs/supergateway.log 2>&1
