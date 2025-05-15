#!/bin/bash
set -e

# Log configuration for debugging
echo "Starting Paperless-NGX MCP Server with SSE transport"
echo "=================================================="
echo "Paperless URL: $PAPERLESS_URL"
echo "SSE Port: $SSE_PORT"
echo "SSE Host: $SSE_HOST"
echo "=================================================="

# Validate environment variables
if [ "$PAPERLESS_URL" == "your-url" ] || [ "$PAPERLESS_TOKEN" == "your-token" ]; then
  echo "ERROR: You must set PAPERLESS_URL and PAPERLESS_TOKEN environment variables"
  exit 1
fi

# Start the supergateway to bridge STDIO to SSE
exec npx supergateway \
  --port "$SSE_PORT" \
  --host "$SSE_HOST" \
  --stdio "npx @nloui/paperless-mcp \"$PAPERLESS_URL\" \"$PAPERLESS_TOKEN\""
