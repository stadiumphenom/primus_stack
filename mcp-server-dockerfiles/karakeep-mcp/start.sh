#!/bin/bash
set -e

# Log configuration for debugging
echo "Starting Karakeep MCP Server with SSE transport"
echo "=================================================="
echo "Karakeep API Address: $KARAKEEP_API_ADDR"
echo "SSE Port: $SSE_PORT"
echo "SSE Host: $SSE_HOST"
echo "=================================================="

# Validate environment variables
if [ "$KARAKEEP_API_ADDR" == "https://karakeep.example.com" ] || [ "$KARAKEEP_API_KEY" == "your-api-key" ]; then
  echo "ERROR: You must set KARAKEEP_API_ADDR and KARAKEEP_API_KEY environment variables"
  exit 1
fi

# Start the supergateway to bridge STDIO to SSE
exec npx supergateway \
  --port "$SSE_PORT" \
  --host "$SSE_HOST" \
  --stdio "npx @karakeep/mcp"
