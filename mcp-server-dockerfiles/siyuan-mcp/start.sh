#!/bin/bash
set -e

# Log configuration for debugging
echo "Starting SiYuan Note MCP Server with SSE transport"
echo "=================================================="
echo "SiYuan Server: $SIYUAN_SERVER"
echo "SSE Port: $SSE_PORT"
echo "SSE Host: $SSE_HOST"
echo "=================================================="

# Validate environment variables
if [ -z "$SIYUAN_TOKEN" ]; then
  echo "ERROR: SIYUAN_TOKEN environment variable is not set"
  exit 1
fi

if [ -z "$SIYUAN_SERVER" ]; then
  echo "WARNING: SIYUAN_SERVER environment variable is not set, using default"
  export SIYUAN_SERVER="http://localhost:6806"
fi

# Try direct execution of the module
echo "Starting supergateway with direct module execution"

# Find the location of the main script
SCRIPT_PATH=$(find /app/node_modules/@onigeya/siyuan-mcp-server -name "server.js" | head -n 1)

if [ -z "$SCRIPT_PATH" ]; then
  echo "ERROR: Could not find server.js in the @onigeya/siyuan-mcp-server package"
  exit 1
fi

echo "Found server.js at: $SCRIPT_PATH"

# Use the local node_modules/.bin path for supergateway
exec ./node_modules/.bin/supergateway \
  --port "$SSE_PORT" \
  --host "$SSE_HOST" \
  --stdio "node $SCRIPT_PATH"
